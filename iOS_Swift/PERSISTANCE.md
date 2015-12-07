## Persistance in iOS

### Why 

Sometimes in an iOS App you need to store some data in the users hard drive so it can **persist** among app launches, hence the name, **persistance.**

This can be something as simple as cache so that the user has a faster experience and doesn't have to make more extra requests to get data.

This can also be the settings or the session if your app has a login component.

Or it can be any kind of app state that you need to store. This can all be acomplished in several ways, each has it's benefits and different complexity levels. I'll try to go trough all from the simplest to the most complex.

### NSUserDefaults

The simplest way to store small amounts of data like user settings or session information is in the User Defaults. **NSUserDefaults** is a singleton class which already handles caching and persisting anything you add to it. You just need to use a string **key** to identify the object you want to persist, and the object must be a property list type (see next section). It is basically a key-value store, that handles caching and on-disk-persistance on the fly for you.

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
    [defaults setObject:firstName forKey:@"firstName"];
    [defaults setObject:lastName forKey:@"lastname"];
    
    NSString *name = [defaults objectForKey: @"firstName"];
    
This is a good place to store settings, and small information like a current logged in user. You can also store a session token here, but it would be safer to do that in the Keychain.

### Property List Serialization

**Property lists** are a way of expressing simple hierarchies of data. Basically, any **NSNumber**, **NSDate**, **NSData** and **NSString** contained in either a **NSArray** or **NSDictionary** (and any combination of them) is considered a property list. You can create Property Lists in XCode as a .plist file, if you have any static data that needs to be read into your app. Or you can create a property list in code then serialize it to disk, and viceversa.

To save Plist compatible data types, you would do so like this: (plist is the dictinoary we want to serialize & save to disk).

	NSDictionary *plist = @{...}
	
	NSString *rootPath = ... // This should be the root document path for your app
    NSString *path = [rootPath stringByAppendingPathComponent: @"DataStore.plist"];
    
    NSData *xmlData;
    NSError *error;
    
    xmlData = [NSPropertyListSerialization dataWithPropertyList: plist
                                                         format: NSPropertyListXMLFormat_v1_0
                                                        options: 0
                                                          error: &error];
    
    if (xmlData) {
        [xmlData writeToFile: path atomically: YES];
    }else{
        DDLogError(@"ERROR : %@", error);
    }
	
To open a Plist file, this is the way you would do it:

	NSString *rootPath = ...
    NSString *path = [rootPath stringByAppendingPathComponent: @"DataStore.plist"];
    
    NSData *plistData = [NSData dataWithContentsOfFile: path];
    
    NSError *error;
    NSPropertyListFormat format;
    id plist;
    
    plist = [NSPropertyListSerialization propertyListWithData: plistData
                                                      options: NSPropertyListMutableContainers
                                                       format: &format
                                                        error: &error];
    
Don't forget to perform nil & error validation, which I excluded for clarity.

So basically, the first code sample turns a property list into data, that can be stored to disk. The second sample turns data included in some file, into a property list, which can be used in code.
	
This is useful if you want to cache some app information, like a bunch of posts, but those objects you want to cache are not custom objects but property list types.

### NSCoding

If the data types you want to save to disk are **Property List** types then you can get away with serializing them pretty easily with property list serialization as we did in the last example. But if you want to serialize your own custom classes you need to use **NSCoding**. 

Using NSCoding consists of two steps. First, all your custom classes need to conform to the **NSCoding** protocol, and implement the two required initializer methods, in which you basically assing a NSString **key** to each property.

	- (id)initWithCoder:(NSCoder *)decoder 
	{
	    self = [super init];
	    if (!self) {
	        return nil;
	    }
	
	    self.title = [decoder decodeObjectForKey:@"title"];
	    self.author = [decoder decodeObjectForKey:@"author"];
	    self.pageCount = [decoder decodeIntegerForKey:@"pageCount"];
	    self.categories = [decoder decodeObjectForKey:@"categories"];
	    self.available = [decoder decodeBoolForKey:@"available"];
	
	    return self;
	}
	
	- (void)encodeWithCoder:(NSCoder *)encoder 
	{
	    [encoder encodeObject:self.title forKey:@"title"];
	    [encoder encodeObject:self.author forKey:@"author"];
	    [encoder encodeInteger:self.pageCount forKey:@"pageCount"];
	    [encoder encodeObject:self.categories forKey:@"categories"];
	    [encoder encodeBool:[self isAvailable] forKey:@"available"];
	}

Afterwards, to serialize/archive to disk you do it like so:

	[NSKeyedArchiver archiveRootObject: modelArray toFile:@"/path/to/archive"];
	
Which gives you NSData that you can store to disk (like the Plist) or even store it inside NSUserDefaults.

And, viceversa, to unarchive:

	[NSKeyedUnarchiver unarchiveObjectWithFile: @"/path/to/archive"];

This is useful when you want to cache or store some app information, like with property list serialization, but the objects are your custom objects.

### Realm

Realm is the "new" kid on the block. It is meant as a Core Data / SQLite replacement. It is a complete custom database (specifically designed for mobile), and an Objective-C and Swift framework to go along with it. 

It is not as feature complete as Core Data because Core Data is much more than just a database and an ORM, but for many use cases Realm is faster and easier to use, and more than enough.

	// Define your models like regular Objective-C classes
	
	@interface Dog : RLMObject
	@property NSString *name;
	@property NSInteger age;
	@end
	RLM_ARRAY_TYPE(Dog)
	@interface Person : RLMObject
	@property NSString             *name;
	@property NSData               *picture;
	@property RLMArray<Dog *><Dog> *dogs;
	@end
	
	// Use them like regular Objective-C objects
	
	Dog *mydog = [[Dog alloc] init];
	mydog.name = @"Rex";
	mydog.picture = nil; // properties are nullable
	NSLog(@"Name of dog: %@", mydog.name);
	
	// Persist your data easily
	
	RLMRealm *realm = [RLMRealm defaultRealm];
	[realm transactionWithBlock:^{
	  [realm addObject:mydog];
	}];
	
	// Query it from any thread
	
	dispatch_async(dispatch_queue_create("background", 0), ^{
	  RLMResults<Dog *> *r = [Dog objectsWhere:@"age > 8"];
	});
	
This is useful when you want to have a full offline experience, or when your apps data is not stored in the cloud but locally. Whenever core data seems like too much functionality for what you need, Realm is a godo alternative.

### Core Data

...