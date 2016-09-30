# Icalia Labs - Best Practices

#### (Based on Prolific's Swift [Style Guide](https://github.com/prolificinteractive/swift-style-guide))

The purpose of these best practices is to help us as a team to solve common problems with good, repeatable solutions.

### Property Observers ###
Cf Apple documentation:

```
Property observers observe and respond to changes in a property’s value. Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.
```

You can use 2 types of property observer:

* *willSet* is called just before the property value is stored.
* *didSet* is called right after the property value is stored.

```swift

	var intValue: Int = 0 {
		willSet(newIntValue) {
			print("About to set intValue to \(newIntValue)")
	  	}
	    didSet {
	    	print("Set intValue to \(intValue)")
	    }
	}

```

`didSet` is very useful when working with a data source array so you can automatically refresh the table view or collection view associated with the array.

```

	var dataSource: [String] {
		didSet {
			self.tableView.reloadData()
		}
	}

```

Be careful to use *didSet* only on an initialized property. A typical example where it is dangerous to use *didSet* is to set an IBOutlet value before the view loaded.

```swift

	class myViewController: UIViewController 
	{
		@IBOutlet weak var label: UILabel!
		
		var text: String {
			didSet {
				self.label.text = text
			}
		}
	}
	
	let myViewController = UIViewController()
	myViewController.text = "Prolific" // Crash because the view controller label has not been initialized yet

```

### Retain Cycle ###

To avoid retain cycle in Swift -- meaning when two objects both have strong references to each other -- use **weak** and **unowned** on your references to avoid having a strong reference on both sides.

* A **weak** reference is a pointer to an object that **doesn't protect** the object from being deallocated by [ARC](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html). The object **can** be nil.
* A **unowned** reference is a pointer to an object that **doesn't protect** the object from being deallocated by [ARC](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html). The object **can't** be nil.

According to Apple's [documentation](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html):

```
Use a weak reference whenever it is valid for that reference to become nil at some point during its lifetime. Conversely, use an unowned reference when you know that the reference will never be nil once it has been set during initialization.
```

##### Example #####
```swift

	internal final class MyClass {
		let notNilInstance = Instance()
	    weak var delegate: MyDelegate?
	
	    func myFunction() {
	        delegate?.doSomething()
	    }
	    
	    func myFunctionWithClosure() {
	    	let closure = { [weak self, unowned notNilInstance] in
		    self?.doSomething() // weak variables are optionals
	    	notNilInstance.doSomethingElse() // unowned variables are not
	    }
	}

```

##### Debug #####

[Here](http://applifebalance.com/posts/retain-cycle-instruments/) is an article on how to diagnose retain cycle bugs in your app using Instruments. Another easy way is to print inside the `deinit` function of your objects and see if they get deallocated.

##### Note #####

Retain cycle doesn't apply to Swift structs since they are passed by value and not by reference.

*Rationale* Retain cycle bugs are very easy to reproduce, being very careful when manipulating pointers is crucial to build a solid app.
