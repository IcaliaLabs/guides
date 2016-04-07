# Icalia Labs - Swift Style Guide

#### (Based on Prolific's Swift [Style Guide](https://github.com/prolificinteractive/swift-style-guide))

## Table Of Contents ##

* [Overview](#overview)
* [Standards](#standards)
	* [File Structure](#file-structure)
	* [Types](#types)
	* [Statement Termination](#statement-termination)
	* [Variable Declaration](#variable-declaration)
	* [Self](#self)
	* [Structs & Classes](#structs--classes)
	* [Bracket Syntax](#bracket-syntax)
	* [Force Unwrap](#force-unwrap)
	* [Error Handling](#error-handling)
	* [Access Modifiers](#access-modifiers)
	* [Type Declarations](#type-declarations)
	* [Type Inference](#type-inference)
	* [Nil Checking](#nil-checking)
	* [Implicit Getters](#implicit-getters)
	* [Enums](#enums)
	* [Use of `final`](#use-of-final)


## Overview ##

The purpose of this guide is to develop 
a universal standard for Swift code that makes our codebases consistent and easy to read. This guide aims for
consistent and clean code written in Swift in line with Apple and the general community.

## Standards ##

### File structure ###

You should not define multiple public/internal types (ie class, struct, enum) in the same file; each type should have its own file.

The following list should be the standard organization of all your Swift files, in this specific order:

Before the type declaration:

* Private Class/Struct/Enum

Inside the type declaration:

* Override Properties
* Properties
* Static/Class Variables
* Static/Class Functions
* Init/Deinit
* Override Functions
* Instance Functions

After the type declaration:

* Extensions

Each section above should be organized by accessibility:

* Public
* Internal
* Private

When implementing a protocol you should create an extension of your class that lives in the same file to separate the core logic of your class and your protocol implementation.

#### Enum & Protocol ####

All enums should live in their own file, except in cases where the enum is declared as private. In cases where the enum is declared private, declare the enum at the top of the file, above the type declaration.

*Rationale*: With enum and protocol types Swift allows defining functions and extensions. Because of that these types can become complex which is why they should be defined in their own file.

#### Usage of MARK / TODO / FIXME ####

To help organize your files you may want to use pragma marks to clearly separate your functions, properties and extensions. For extensions, use one MARK per extension. For example, `// MARK: UITableViewDelegate Functions` instead of `// MARK: Extensions`.

Xcode is also able to display `TODO` and `FIXME` tags directly in the source navigator, you should consider using them to find your notes inside your files.

`// TODO: implement this feature`

`// FIXME: fix it it's not working`

Other conventional comment tags, such as `NOTE` are not recognized by Xcode.

### Types ###

Prefer Swift native types over Objective-C types when possible. Because Swift types bridge to Objective-C, you should avoid types like NSString and NSNumber in favor of Int or String.

*Rationale*: Avoid subclassing NSObject or using the @objc flag unless it is required to implement an NSObjectProtocol type. Subclassing NSObject or using the @objc flag automatically creates an Objective-C object that uses dynamic dispatch over the preferred static of Swift which can impact the performance of the app.

**Preferred:**

```swift

	class MyClass {
	...
	}
	
```

**Not preferred:**

```swift

	@objc class MyClass {
	...
	}
	
```

If you need functionality from an Objective-C type that is not available in its corresponding Swift type (for instance, needing an NSString function that is not available on String), cast your Swift raw type to the corresponding Objective-C type instead of declaring the type as the Objective-C type.

**Preferred:**

```swift

	let scale = 5.0
	let scaleString = (5.0 as NSNumber).stringValue
	let scaleInt = Int(scale)
	
```

**Not preferred:**

```swift

	let scale: NSNumber = 5.0
	let scaleString = scale.stringValue
	let scaleInt = scale.integerValue

```


### Statement Termination ###

Unlike Objective-C, omit the use of `;` to terminate statements. Instead, simply use new lines to indicate the end of a statement. 

```swift

	let myVar = 0
	doSomething(myVar)
	
	return

```

Avoid multiple statements on a single line.

```swift

	guard let obj = myObj else { print("Something went wrong"); return; } // Wrong! Instead, place each item on its own line.

```

### Variable Declaration ###

For declaring variables, favor `let` instead of `var` unless you need a mutable object or container.

```swift

	func formatDate(date: NSDate) -> String {
	    let dateFormatter = NSDateFormatter() // In this case, use `let` since the variable `dateFormatter` never changes once set
	    dateFormatter.dateStyle = .ShortStyle
	    return dateFormatter.stringFromDate(date)
	}
	
	func arrays() {
	    let array = ["Hello", "Ciao", "Aloha"] // use let here since this is an immutable container
	
	    var mutableArray = [String]() // Use var here since this container is mutable
	    mutableArray.append("Farewell")
	    mutableArray.append("Arrivederci")
	}

```

### Self ###

Never use the `self` modifier except in cases where it is necessary for the compiler or to alleviate conflicts
with other variable declarations.

```swift

	class Object {
		private var name = ""
		
		func useName() {
			// Let self be implied when it can be understood.
			otherObject.doSomethingWithName(name)
			setName("Will Smith")
		}
		
		func setName(name: String) {
			// Use self here to prevent conflicts with the `name` parameter being passed.
			self.name = name
		}
		
		func setNameAsync(newName: String) {
			// Use implicit self outside closures...
			otherObject.doSomethingWithName(name, then: { 
				// .. but within, you must use self to ease the compiler.
				self.setName("Jason")
			})
		}
	}

```

*Rationale*: The idea behind this is that implicit use of self makes the conditions where you _must_ use self
(for instance, within closures) much more apparent and will make you think more on the reasons why you are using it.
In closures, think about: should `self` be `weak` instead of `strong`? Apple has even rejected a request to enforce use of `self` for this reason, [among others](http://ericasadun.com/2016/01/06/the-swift-evolution-proposal-se-0009-rejection/).

### Structs & Classes ###

In Swift, structs maintain value semantics which means their values are copied when assigned. Classes, on the other hand, act like pointers from C
and Objective-C; they are called reference types and the internal data is shared amongst instances of assigning.

When composing your types, consider carefully what they're going to be used for before choosing what they should end up being. In general, 
consider structs for types that are:

* Immutable
* Stateless
* Have a definition for equality

Swift structs also have other, tangible benefits as well:

* Faster 
* Safer due to copying rather than referencing
* Thread safe -- copies allow mutations to happen independently of other instances.

In general, you should favor structs and protocols over classes; even in cases where polymorphism would dictate the usage of a class, consider if you can
achieve a similar result via protocols and extensions. This allows you to achieve polymorphism via *composition* rather than *inheritance*.


### Bracket Syntax ###

For brackets, when dealing with looping or branching statements (if, switch) or blocks, prefer having the opening brace on the same line as the statement opening it:

```swift

	if true == false {
	}
	
	let doSomething: () -> Void = { 
	}

```

When dealing with everything else (classes, enums, methods, functions) prefer having the opening brace on the next line, for better readability:

```swift

	internal final class MyObject 
	{
	}
	
	internal enum MyEnum 
	{
	}
	
	func doSomething() 
	{
	}

```

### Force Unwrap ###

Unless there is a situation that absolutely calls for it, usage of the force-unwrap operator `(!)` should
be minimized, if not eliminated all together. With the many and varied ways of unwrapping optionals, it is
safer and simpler to declare variables as optional and unwrap them when needing their values than it is
to force-unwrap them and potentially introduce runtime errors into the code base.

```swift

	if let text = self.textLabel?.text {
	    doSomethingWithText(text)
	}

```

If you are interoping from Objective-C and the declaration automatically translates into force-unwrapped
parameters, replace them with `?` parameters instead.

The one exception to this rule are IBOutlets. @IBOutlets may be declared using `!` so long as they are expected
to exist for the lifetime of the view controller object:

```swift

	@IBOutlet private weak var textLabel: UILabel!

```

### Error Handling ###

The emergence of `try / catch` in Swift 2 has added powerful ways to define and return errors when something fails. The emergence of `ErrorType`
as well for defining errors makes error definitions much more convenient over the cumbersome `NSError`. Because of this, for functions that can have multiple
points of failure, you should always define it as `throws` and return a well-defined `ErrorType`.

Consider the following contrived example:

```swift

	func multiplyEvensLessThan10(evenNumber: Int) -> Int? 
	{
		guard evenNumber % 2 == 0 && evenNumber < 10 else {
			return nil
		}
		
		return evenNumber * 2
	}

```

The function above fails because it only expects evens less than 10 and returns an optional if that is violated. While this works and is simple, it
is more Objective-C than Swift in its composition. The caller may not know which parameter they violated. For Swift, instead consider refactoring it as follows:

```swift

	internal enum NumberError: ErrorType {
		case NotEven
		case TooLarge
	}
	
	func multiplyEvens(evenNumber: Int) throws -> Int {
		guard evenNumber % 2 == 0 else {
			throw NumberError.NotEven
		}
		
		guard evenNumber < 10 else {
			throw NumberError.TooLarge
		}
		
		return evenNumber * 2
	}

```

The above, while slightly more cumbersome, this has well-defined benefits:

* The caller is able to explicitly determine why their call to the function failed and thus can take active steps to recover:

```swift

	let result: Int
	do {
	    result = try multiplyEvens(3)
	} catch NumberError.NotEven {
	    return 0
	} catch NumberError.TooLarge {
	    print("The Number entered was too large! Try again.")
	    return -1
	} catch {
	    fatalError("Unhandled error occurred.")
	}
	
	return result

```

* Try/catch semantics allow the caller to still retain the old optional functionality if the error is not relevant and they only care about the outcome:

```swift

	let result: Int? = try? multiplyEvens(1)

```

* Or, if the caller knows that it will not violate any of the parameters for a valid input:

```swift

	let result: Int = try! multiplyEvens(2)
	
```

So, even though we've now modified our API to use swift exceptions, we can still retain the old Objective-C functionality giving the caller the choice
of how they wish to handle the result of this failable operation.

#### NSError ####

In general, you should avoid `NSError` in Swift in favor of defining your own `ErrorType`. However, in the event you do need to use `NSError` 
(for interop with Objective-C, for instance):

* Define a proper domain for your `NSError`. This should be specific to your module and ideally would be reflective of your bundle identifier (i.e. `com.icalialabs.MyApp`)
* Define a list of the various error codes and what they translate to. These should be some sort of easily readable constant or enum value so that way the caller is able to determine what exactly failed.
* In the userInfo, include _at least_ a localized description (`NSLocalizedDescriptionKey`) that accurately and concisely describes the nature of the error.

### Access Modifiers ###

Always specify access modifiers to top-level definitions. Do not specify them otherwise unless
the modifier is needed:

```swift

	internal final class Object {
	    var myInt: Int
	
	    private func doWork() {
	        ...
	    }
	}

```

Further, the access modifier should always be presented first in the list before any other modifiers:

```swift

	// Good!
	private unowned var obj: Object
	
	internal func doSomething() {
	}
	
	// Wrong!
	weak public var obj: Object?
	
```

### Type Declarations ###

When declaring types, the colon should be placed immediately after the identifier followed by one space
and the type name.

```swift

	var intValue: Int
	
	// Do NOT do this
	var intValue : Int

```

In all use-cases, the colon should be associated with the left-most item with no spaces preceding and one space afterwards:

```swift

	let myDictionary: [String: AnyObject] = ["String": 0]

```

### Type Inference ###

Prefer letting the compiler infer the type instead of explcitly stating it, wherever possible:

```swift

	var max = 0 		// Int
	var name = "John" 	// String
	var rect = CGRect()	// CGRect
	
	// Do not do:
	
	var max: Int = 0
	var name: String = "John"
	var rect: CGRect = CGRect()
	
	// Ok since the inferred type is not what we wanted:
	
	var max: Hashable = 0 // Compiler would infer Int, but we only want it to be hashable
	var name: String? = "John" // Compiler would infer this not to be optional, but we may need to nil it out later.

```

*Rationale* The compiler is pretty smart, and we should utilize it where necessary. It is generally obvious what the 
type is going to be in the instances above, so unless we need to be more explicit (as in the last examples above),
it is better to omit unneeded words.

### Nil Checking ###

Favor `if-let` checking over direct nil checking in all cases except when the result of this check is required:

```swift

	guard let item = myItem else {
		return
	}
	
	doSomethingWith(item)

```

```swift

	if let _ = error { // Prefer this over `if error != nil`
		fatalError()
	}
	
```
	
```swift

	func is	Error(error: Error?) -> Bool {
		return (error != nil) // In this case, we need the result of the bool, and this is much cleaner than the other options.
	}

```

### Implicit Getters ###

When overriding only the getter of a property, omit the use of `get`:

```swift

	var myInt: Int {
		return 0
	}
	
	// Do not do this:
	var myInt: Int {
		get {
			return 0
		}
	}

```

For all other cases, specify the modifier as needed (`set`, `didSet`, etc.). This is compiler enforced.

*Rationale* The getter is implied enough to make sense without having to make it explicitly. It also cuts down on
unneccessary verbiage and spacing to make code clearer.

### Enums ###

For enum declarations, declare each enum case on a new line with its own `case` statement instead of a comma-separated list.

```swift

	internal enum State 
	{
		case Open
		case Closed
		case Pending
		case Faulted
	}

```

Prefer singular case for enum names instead of plural: `State` vs. `States`:

```swift

	var currentState = State.Open
	var previousState = States.Closed // Reads less clearly than the previous option.

```

For enums with raw values, declare the raw value on the same line as its declaration:

```swift

	internal enum HTTPMethod: String 
	{
		case Get = "GET"
		case Post = "POST"
	}

```

For any other functions or properties associated with the enum, place them after the last case item in the enum list:

```swift

	internal enum State 
	{
		case Open
		case Closed
		case Pending
		case Faulted
		
		func nextState() -> State {
			...
		}
	}

```

In cases where the enum's type name can be omitted, do so:

```swift

	let state = State.Open
	
	if state == .Closed { ... // Prefer .Closed instead of State.Closed

```


### Use of `final` ###

Classes should always be marked as `final` unless they are being used as a base class for another type. In instances where a class can be subclassed,
any function or variable that should not be overriden by a subclass should be diligently marked as `final`.

```swift

	// Not built for inheritance.
	internal final class Object 
	{ 
	
	}
	
	// Purposefully utilizable as a base class
	internal class BaseClass 
	{ 
		func doSomething () 
		{
		}
		
		// Properly marked as final so subclasses cannot override
		final func update() 
		{ 
		}
	}
	
	internal final class SubClass: BaseClass 
	{	
		override func doSomething() 
		{
			update()
		}	
	}

```

*Rationale* Subclassing in instances where the original class was not built to support subclasses can be a common source of bugs. Marking classes as `final`
indicates that it was developed under the assumption that it would act on its own without regard for subclasses. 
