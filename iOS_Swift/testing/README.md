#iOS Testing

In iOS the practice of implementing TDD or BDD practices is not that common. There is a lot of confusion in the iOS developer community about what to test, or even if it is actually worth it. What do I mean by this?

First of all TDD practices imply that you should write test first and then write your code so that those test pass. That sounds easy, but the truth is that given the tools, architecture, and language nature used for iOS development that becomes not actually harder, but also can't follow the rule exactly as it is. Why is that you ask? 

First of all, when we work in XCode there are many things that can be done in Interface Builder whithout needing any code at all. You can connect segues, to make a button work. You can connect actions with code just by dragging and dropping. So that made it impossible to test this kind of things. Well not entirely true there was this tool called automation that made it possible to make authomated UI tests, but in order to make it work not only you had to know javascript, but also code a whole lot just to make a simple test. That was up until version 7 of Xcode. Which as of the writting of this post is the latest mayor version of XCode. After that apple finally released tools for simple UI test which you can integrate with your test target. And even though apple released these tools, it still leaves the question of what would you test with these UI, because interfaces in iOS change constantly, so making very specific test would make testing a hassle way bigger than of the benefits we get from testing.

Now the combination of graphic tools, and code is not the only problem with testing in iOS, but also the way it's architecture work. iOS base architecture is MVC. Models we know how to test they are have tipical functions that receibe some parameter and return some information. The problem arises when you need to test controllers, their main function should be only to act as an intermediary between the view and the models, and give control to the flow of the app. Those things can't be tested by simple unit tests. In fact if you have functions in a controller which you can test that way, there is strong probablity that the method should be on the controller but rather on some business logic class. Now there is also the problem that many methods in the view controller are called by the own system, and finding ways to test those methods would also result in so much more code. Which would complicate even simple apps. Now if you don't test those methods you will also have a low code coverage, wich is also reflects bad on your tests.

The third main problem with iOS and TDD, is the nature of the language. As it is a compiled language you can not write fake functions of a class first, and then have them written. You must have at least the skeleton of the class to make your test otherwise the testing class will complain that the functions do not exist and won't run any tests. Thus breaking a little with the process of TDD. Now there also comes the part when you have to test for responses of server, or getting data into or from a database. Usually you would get help of tools to make mocks of those clases working in diferent conditions easily. Fact is there are many libraries that help for this in Objective-C. The problem is with swift due to the nature of the language those mocks can't be done dinamically, you would have to code the mocking classes yourself, and then again you have the problem of having double work. Now if you make your test in Objective-C you could only test those methods and classes that objc could see, thus either you would have to eliminate the use of the new features that swift provides, or not meet the code coverage that it should cover.

I hope by now you notice why testing in iOS has been a practice that very few have adopted, and this also creates a problem of not having many resources and places to go in matters of testing in this platforms. So what should we do then? are these nuissances enough reason to ignore completly having test in our code? If not how should we go about testing our apps?

To answer this question lets have a quick look of the advantages vs the disadvantages of using tests in our code gathered from a post from [raywenderlich](http://www.raywenderlich.com/101306/unit-testing-tutorial-mocking-objects):

| Advantages | Disadvantages |
| --- | --- |
| **Confidence:** You can demonstrate that your code works. | **More code:** In projects with high test coverage it’s possible to have more test code than functional code. |
| **Quick feedback:** You can use unit tests to quickly validate code that is buried many layers deep in your app navigation — things that are cumbersome to test manually. | **More to maintain:** When there is more code, there is more to maintain. |
| **Modularity:** Unit tests help keep you focused on writing more modular code. | **No silver bullet:** Unit tests don’t (and can’t) ensure that your code is free of bugs. |
| **Focus:** Writing tests for micro features keep you focused on the small details. | **Takes longer:** Writing tests takes time |
| **Regression:** Be sure that the bugs you fixed stay fixed — and aren’t broken by subsequent fixes. |
| **Refactoring:** Until Xcode gets smart enough to refactor your code on its own, you’ll need unit tests to validate your refactoring. |
| **Documentation:** Unit tests describe what you think the code should do; they serve as another way to document your code. |

So as we can see there are many advantages to using tests that we don't wan't to be missing when we are striving to write the best code for the client as possible. So that leaves us to decide how to, and what to test. What would be the optimal way of writing test without compromising too much time, and without our coding of test becomes even harder than making the actual code, and also **don't compromise the good coding practices** in doing so.
So here are the steps to follow and tips in order to test your code in iOS.

## How to get started

### Before starting

First of all let me tell you of some tool that you will need to download or add to your pod file for use with our tests:

* Quick - pod 'Quick'
* Nimble - pod 'Nimble'

This tools will help us to have a BDD testing style rather than the raw test that come integrated with XCode. You can read more about the advantages of this in the following links, but basically this let us have a cleaner arrangement and readability of our tests:

* http://www.toptal.com/freelance/your-boss-won-t-appreciate-tdd-try-bdd
* http://www.slideshare.net/bgesiak/quick-better-tests-with-incremental-setup
* http://davemeehan.com/technology/unit-testing/test-and-behaviour-driven-development-on-ios-with-kiwi
* https://realm.io/news/testing-in-swift/
* https://github.com/Quick/Quick/tree/master/Documentation

Why did we choose this framework versus his other friends out there? This one has thight integration not only with objective-c, but it is written in swift which lets you take advantage of all the features that swift brings. Also it has a very good integration with Xcode, which makes it a perfect fit for our development tools, which is something that the other frameworks do not have.

### Setup

We will setup our proyect to have test Coverage, code tests, and UI tests.

The Unit Testing and UITesting support can be added when creating the project.
<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-01-29 at 2.29.25 p.m..png" style="height:300px"/></div>
First we will enable Test Coverage. Go to your squeme settings, and make sure the gather coverage data box is checked: 
<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-01-29 at 2.46.59 p.m..png" style="height:300px"/></div>
Now if you didn't add the testing targets when creating the project, here is the way to add them manually. Go to your project's target list. And select the `+` sign at the bottom to add a new target
<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-01-29 at 2.54.20 p.m..png" style="height:300px"/></div>
In the target menu that you see select the Test section and add the corresponding bundle you want to add.
<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-01-29 at 2.58.11 p.m..png" style="height:300px"/></div>
Give it a name in the screen that follows. And the language you will be testing on. For this guide purposes we used swift.
<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-01-29 at 3.01.35 p.m..png" style="height:300px"/></div>
Once you have added those bundles two new folders will appear:
<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-01-29 at 3.05.20 p.m..png" style="height:300px"/></div>
We are now ready to add quick and nimble. In your pod file add them to your testing targets only. And run a pod install.
<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-01-29 at 3.08.58 p.m..png" style="height:300px"/></div>
Now that everything is ready to start making our tests, lets first get a look at the main screens you will be looking at when making your tests. Build your project for testing.
<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-01-29 at 3.13.22 p.m. (2).png" style="height:300px"/></div>
It should compile and finish with all tests passing. You can have a look at the status of the tests and verify this if you select the test navigator bar.
<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-01-29 at 3.25.49 p.m..png" style="height:300px"/></div>
Now to see your test coverage. Select the report Navigation tab. Select the test you just ran. And in the main screen you are presented with all the tests runned, and three tabs on the top. Select the coverage tab.
<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-01-29 at 3.32.44 p.m..png" style="height:300px"/></div>
For the rest of this guide let's work on a demo project

## Using Quick and Nimble with Models

To begin using quick and nimble. Lets imagine we will have to test the following things of a model person:

* A person should be able to always display his or her full name as a string.
* A person can be considered the same person as long as it has the same name and the same lastname
* A person must always have a name and a lastname

To do this you will have to:

1. Add a Unit Test Case Class File to the Unit Testing Target
2. Delete all default info created by XCode
3. import Nimble and Quick
4. define a class that inherits from `QuickSpec`
5. you will be required to override a spec function declared by the QuickSpec parent, this is where all your specs will be.
6. Last but not least in order to access code from your app target you must import it as testable so that even internal methods are testable
```swift
import Quick
import Nimble
@testable import ILTestingDemo

class PersonSpec: QuickSpec {
	override func spec() {
    }
}
```
7. We can now start writing our test conditions (For information on all matchers and functions of Quick and Nimble review their documentation)
```swift
	override func spec() {
        let personSample = Person(name: "Monica", lastName: "Geller")
        
        describe("full name") {
            context("when required") {
                it("should always have the right info") {
                    expect(personSample.fullName).to(equal("Monica Geller"))
                }
            }
        }
        
        describe("a person") {
            context("when compared for equality to another person") {
                let anotherPerson = Person(name: "Monica", lastName: "Geller")
                let anotherPersonWithDifferentName = Person(name: "Monica", lastName: "Schultz")
                
                it("should be considered the same as long as the name and lastname are equal") {
                    expect(personSample == anotherPerson).to(beTrue())
                    expect(personSample == anotherPersonWithDifferentName).to(beFalse())
                }
            }
            
            context("when intantiating with name and lastname parameters") {
                let name = "Timmy"
                let lastName = "Turner"
                let person = Person(name: name, lastName: lastName)
                it("must reflect that result when being used") {
                    expect(person.name) == name
                    expect(person.lastName) == lastName
                }
                
                it("must always have a name and a lastname") {
                    expect(Person(name: "", lastName: "")).to(beNil())
                    expect(Person(name: "", lastName: "Morgan")).to(beNil())
                    expect(Person(name: "Jack", lastName: "")).to(beNil())
                    expect(Person(name: "Jack", lastName: "Morgan")).toNot(beNil())
                }
            }
        }
    }
```
8. Now if you try to compile it won't let you, even though we told it not to run those test cases with the `x` before each spec in Quick, the compiler still runs and complaints when something is not declared. So this is why I was telling you that you must have at least the skeleton of the class to be able to write the tests. So lets write the skeleton now.
9. Make a new file in your's apps target for the class Person.
10. Write the following code as a skeleton:
```swift
public func ==(lhs: Person, rhs: Person) -> Bool {
    return false
}

public class Person: Equatable {
    let name: String
    let lastName: String
    var fullName: String {
        return ""
    }
    
    init(name: String, lastName: String) {
        self.name = name
        self.lastName = lastName
    }
}
```
11. Now if you build for tests, it will compile but no quick test of that spec will be run, from here you would be taking out the `x`'s you are ready to test. That means the parts of the code for which your app already is supposed to comply with the spec.
12. This is the way in which we can more closely conform to the TDD process. Some expects are not necessary, and some might need to change depending on how you write your skeleton. To see the resulting code to make this work, refer to the demo project.


## Tips and tricks of common tasks

Now the tests that we wrote earlier are the easy ones, there are parts of the code that are trickier, mostly when making tests for view controllers, but also for network requests, and persistance. For those cases you need help of Mocks, and other work arounds for which here are some tips that might help in those cases.

### Server Request

A common task that you will face is writting test for functions that make network requests. Now you don't want to test against the real functions, not only because those requests may take lots of time but also because you can't know what the answer of the server. Tests have to always be deterministic, that means that their response can't change over time. Your tests can't depend on whether the server is up or down. Thus to test functions that make this kind of calls you need the help of stubs and funtions.

As an example we have created a new class called PersonService and added a function to the class that can retreive all people from a server:

```swift

func fetchAllPeople() -> Promise<[Person]> {
        return Promise {
            fulfill, reject in
            
            let request = NSURLRequest(URL: NSURL(string: "https://dummy.server.com/people")!)
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    reject(error)
                } else if let data = data {
                    fulfill(people(data))
                }
            })
        }
    }

```

In order to test this we will need to create a PersonServiceMock class in your unit tests target. In that class you will inherit from your actual Person class, but will override the fetchAllPeople() function, and also create a variable so that we can inject the proper result to return from our tests.

```swift

import Foundation
import PromiseKit
@testable import ILTestingDemo

enum Result<T> {
    case Success(T)
    case Failure(ErrorType)
}

enum PersonMockError: ErrorType {
    case NoResultForTestSet
}

class PersonServiceMock: PersonService {
    var fakeResult: Result<[Person]> = Result.Failure(PersonMockError.NoResultForTestSet)
    
    override func fetchAllPeople() -> Promise<[Person]> {
        switch fakeResult {
        case .Success(let people):
            return Promise(people)
        case .Failure(let error):
            return Promise(error: error)
        }
    }
}

```

**Note:** If you are using objective-c, there are frameworks like OCMock and OCMockito, that let you mock classes without needing to create a separate mock class with the help of swizziling. This frameworks do not work with swift because of it static nature. Besides there are some people that argue that swizziling is not a good practice as it hides behaviour.

Now as this is functions are totally fake, it doesn't make much sense to make tests in a spec for the class (ex. PersonServiceSpec.swift) but rather this mock classes will be injected in other classes, and view controllers that make use of this funtions so that you can test their behavior. You can see an example of what I am talking about in the view controller testing sections

### View Controller Testing

View controllers are tricky to test, here are a few tips for testing some of the things in view controllers.

#### Methods called by the system

Some functions like the viewDidLoad are called by the system. The first thing you would think is to call it directly from your tests, except that would not garantee that everything works as is supposed to because there is some preparation the system makes before calling this method when the view is loading. So imagine the following view for our view controller:

<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-02-03 at 9.56.22 a.m..png" style="height:300px"/></div>

And we have the following code for the view controller (the outlets are connected):

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectedUserLabel: UILabel!
    var user: Person?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        selectedUserLabel.text = NSLocalizedString("NO_USER_SELECTED_TEXT", comment: "No user selected")
    }
}
```

If our specs would test for the viewDidLoad method directly like this:

```swift
		var viewController: ViewController!
        var navigationController: UINavigationController!
        
        beforeEach {
            navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
            viewController = navigationController.topViewController as! ViewController
        }
        
        describe("the user label") {
            context("when view has just loaded") {
                beforeEach {
                    viewController.viewDidLoad()
                }
                
                it("should not be nil") {
                    expect(viewController.selectedUserLabel).toNot(beNil())
                }
                
                it("should tell the user that no user has been selected") {
                    expect(viewController.selectedUserLabel?.text).to(equal(NSLocalizedString("NO_USER_SELECTED_TEXT", comment: "")))
                }
            }
        }
```

our tests would crash at runtime. This is because the outlets are setup before loading the view. So how can we tell the controller to do that setup, and call the viewDidLoad method?

There is a simple trick for that instead of calling the viewDidLoadMethod of the viewController, just call the view property of the controller and it will work its magic. So our testing code will end up like this:

```swift
		var viewController: ViewController!
        var navigationController: UINavigationController!
        
        beforeEach {
            navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
            viewController = navigationController.topViewController as! ViewController
        }
        
        describe("the user label") {
            context("when view has just loaded") {
                beforeEach {
                    _ = viewController.view
                }
                
                it("should not be nil") {
                    expect(viewController.selectedUserLabel).toNot(beNil())
                }
                
                it("should tell the user that no user has been selected") {
                    expect(viewController.selectedUserLabel?.text).to(equal(NSLocalizedString("NO_USER_SELECTED_TEXT", comment: "")))
                }
            }
        }
```


#### Calls to functions of instances that have network, core data, or other nondeterministic dependencies

When making calls to nondeterministic dependencies you will need the help of mocking classes as talked about in the server request section. But in order to use those mocking classes instead of the real ones we will have to use dependency injection. Unfortunately this does mean that we have to create our code with our tests into account. Let's see an example of this.

Imagine we have a class that when it loads it makes a request to fetch all people from a server:

```swift
var selectedUser: Person?
    var people: [Person]?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllPeople()
    }

    func fetchAllPeople() {
        let personService = PersonService()
        personService.fetchAllPeople().then { (people) -> Void in
            self.people = people
        }.error {
            error in
            let alertController = UIAlertController(title: "Error", message: "Couldn't fetch people", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(alertAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
```

If we would write it like this it would not be possible to change the fetchAllPeople function which PersonService to use. So instead of writting the function like this we should use the power of swift default parameters so that this is the only the declaration of the function is changed, but all other parts where our function is used can stay the same:

```swift
func fetchAllPeople(personService: PersonService = PersonService()) {
        personService.fetchAllPeople().then { (people) -> Void in
            self.people = people
        }.error {
            error in
            let alertController = UIAlertController(title: "Error", message: "Couldn't fetch people", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(alertAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
```

With this new declaration of the function, there is no need to change nothing in the viewDidLoad method, and now we can easily test it's functionallity:

```swift
		var userTableController: UserTableViewController!
        let allPeople = [Person(name: "jacob", lastName: "Wells")!, Person(name: "jessica", lastName: "Parker")!]
        beforeEach {
            userTableController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("userTableViewController") as! UserTableViewController
        }
        
        describe("a fetch for users") {
            context("when succesful") {
                beforeEach {
                    let service = PersonServiceMock()
                    service.fakeResult = Result.Success(allPeople)
                    userTableController.fetchAllPeople(service)
                }
                
                it("should update the users") {
                    expect(userTableController.people).toEventually(equal(allPeople), timeout: 3)
                }
            }
        }
```

#### System delegate methods

For delegates like table view controllers you may call this functions directly:

```swift

		describe("table view") {
            context("when all people have been fetched sucessfully") {
                beforeEach {
                    userTableController.people = allPeople
                }
                
                it("has as many rows as people in it") {
                expect(userTableController.peopleTableView.dataSource?.tableView(userTableController.peopleTableView, numberOfRowsInSection: 0)) == userTableController.people!.count
                }
                
                it("displays a persons full name for each row") {
                    
                    for (index, person) in userTableController.people!.enumerate() {
                        expect(userTableController.peopleTableView.dataSource?.tableView(userTableController.peopleTableView, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: 0)).textLabel?.text).to(equal(person.fullName))
                        
                    }
                }
            }
            
            context("when there is no people") {
                beforeEach {
                    userTableController.people = nil
                }
                
                it("has cero rows in it") {
                    expect(userTableController.peopleTableView.dataSource?.tableView(userTableController.peopleTableView, numberOfRowsInSection: 0)) == 0
                }
            }
        }
    }


```

**Note:** You can create your own custom matchers in Nimble, so that test code remains clean and readable. For example, you could change this lines:

```swift
for (index, person) in userTableController.people!.enumerate() {
	expect(userTableController.peopleTableView.dataSource?.tableView(userTableController.peopleTableView, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: 0)).textLabel?.text).to(equal(person.fullName))
                        
}
```
for the following:

```swift
let peopleFullNames: [String] = userTableController.people!.map{person in person.fullName}
                    expect(userTableController.peopleTableView).to(CustomMatchers.matchEachCell(info:{
                        cell in
                        return cell.textLabel?.text ?? ""
                        }, withCorresponding: peopleFullNames))
```
To see this example working refer to the sample project in the guides.

#### Adding views to the hierarchy

If you go to the code coverage section after having done all the steps form above. You will see that even though we tested for fetchAllPeople method, it is only half way covered.
<div style="width:100%; text-align:center"><img src="./resources/Screen Shot 2016-02-03 at 4.48.50 p.m..png" style="height:150px"/></div>

That is because we haven't tested yet the case for failing to retrieve users from the server. In the case that happens we will need to test that alert showing the error is presented. The code to test that case would look something like this:

```swift
describe("a fetch for users") {
            
            context("when failed to retrieve users") {
                beforeEach {
                    enum ServerError: ErrorType {
                        case ServerUnreachable
                    }
                    
                    let service = PersonServiceMock()
                    service.fakeResult = Result.Failure(ServerError.ServerUnreachable)
                    userTableController.fetchAllPeople(service)
                }
                
                it("should show an alert about the error") {
                    expect(userTableController.presentedViewController).toEventually(beAnInstanceOf(UIAlertController), timeout: 4)
                }
            }
        }

```
However after running this code you will findout that it won't pass the test indicating that it expected an instance of UIAlertController but got nil instead.

If you put a breakpoint and go to the log section you will find out the cause of the problem, there is a message that says `Warning: Attempt to present <UIAlertController: 0x7f863d9052b0> on <ILTestingDemo.UserTableViewController: 0x7f863bcccee0> whose view is not in the window hierarchy!`

We never added our view to the running application. In order for this to work, we will need to add the following line of code `UIApplication.sharedApplication().keyWindow!.rootViewController = userTableController` in our prep for the test:

```swift
describe("a fetch for users") {
            
            context("when failed to retrieve users") {
                beforeEach {
                    UIApplication.sharedApplication().keyWindow!.rootViewController = userTableController
                    enum ServerError: ErrorType {
                        case ServerUnreachable
                    }
                    
                    let service = PersonServiceMock()
                    service.fakeResult = Result.Failure(ServerError.ServerUnreachable)
                    userTableController.fetchAllPeople(service)
                }
                
                it("should show an alert about the error") {
                    expect(userTableController.presentedViewController).toEventually(beAnInstanceOf(UIAlertController), timeout: 4)
                }
            }
}
```

### Using static or class methods 

Somtimes you might have class methods and for this it gets a little trickier to test and make mocks of this methods. So lets imagine that instead of having a PersonService, you have a fetchAll class method in the Person class:

```swift
public func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name && lhs.lastName == rhs.lastName
}

public class Person:Equatable, CustomStringConvertible {
    let name: String
    let lastName: String
    var fullName: String {
        return "\(name) \(lastName)"
    }
    public var description: String {
        return "<Person: {name:\(name), lastname:\(lastName)}>"
    }
    
    init?(name: String, lastName: String) {
        self.name = name
        self.lastName = lastName
        if self.name == "" || self.lastName == "" {
            return nil
        }
    }
    
    class func fetchAll() -> Promise<[Person]> {
        return Promise {
            fulfill, reject in
            
            let request = NSURLRequest(URL: NSURL(string: "https://dummy.server.com/people")!)
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    reject(error)
                } else if let data = data {
                    fulfill(people(data))
                }
            })
        }
    }
    
    private class func people(fromData: NSData) -> [Person] {
        return [
            Person(name: "Bianca", lastName: "Smith")!,
            Person(name: "monica", lastName: "Jones")!,
            Person(name: "Tim", lastName: "Turner")!,
            Person(name: "Tony", lastName: "Stark")!,
            Person(name: "Sasha", lastName: "Minsk")!,
            Person(name: "Emily", lastName: "Carrey")!]
    }
}
```

If you do this then the dependency injection of your code should change, as you can no longer provide an instance of a class, now you have to provide the class dynamically:

```swift
func fetchAllPeople(personType: Person.Type = Person.self) {
        personType.fetchAll().then {
            (people) -> Void in
                self.people = people
                self.peopleTableView.reloadData()
            }.error {
                error in
                let alertController = UIAlertController(title: "Error", message: "Couldn't fetch people", preferredStyle: UIAlertControllerStyle.Alert)
                let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
                alertController.addAction(alertAction)
                self.presentViewController(alertController, animated: true, completion: nil)
        }
}

```

And as you have no instances anymore, now you have to change your mock class to be able to give it fakeResults. You could change your instance variable to a class variable, but as they now share the same space of memory that could risk a race condition between the succesfull and the failure cases. So in order to solve that problem, we are going to create two subclasses of your mocking class, one for success, and the other one for failure. And change the variable to a computed property:

```swift

enum PersonMockError: ErrorType {
    case NoResultForTestSet
}

class PersonMock: Person {
    enum Result {
        case Success([Person])
        case Error(ErrorType)
    }
    
    class var fakeResult: Result {
        return Result.Error(PersonMockError.NoResultForTestSet)
    }
    
    override class func fetchAll() -> Promise<[Person]> {
        switch fakeResult {
        case .Success(let people):
            return Promise(people)
        case .Error(let error):
            return Promise(error: error)
        }
    }
}

class PersonMockFetchAllSuccess: PersonMock {
    static var allPeople: [Person]!
    
    override class var fakeResult: Result {
        return PersonMock.Result.Success(allPeople)
    }
}

class PersonMockFetchAllError: PersonMock {
    static var error: ErrorType!
    
    override class var fakeResult: Result {
        return PersonMock.Result.Error(error)
    }
}

```

And our test would be modified to be like this:

```swift

    context("when succesful") {
                beforeEach {
                    PersonMockFetchAllSuccess.allPeople = allPeople
                    userTableController.fetchAllPeople(PersonMockFetchAllSuccess.self)
                }
                
                it("should update the users") {
                    expect(userTableController.people).toEventually(equal(allPeople), timeout: 3)
                }
            }
            
            context("when failed to retrieve users") {
                beforeEach {
                    UIApplication.sharedApplication().keyWindow!.rootViewController = userTableController
                    enum ServerError: ErrorType {
                        case ServerUnreachable
                    }
                    
                    PersonMockFetchAllError.error = ServerError.ServerUnreachable
                    userTableController.fetchAllPeople(PersonMockFetchAllError.self)
                }
                
                it("should show an alert about the error") {
                    expect(userTableController.presentedViewController).toEventually(beAnInstanceOf(UIAlertController), timeout: 4)
                }
            }
        }

```

### app flow (ui tests)


## Useful Links you might also want to check

http://www.raywenderlich.com/101306/unit-testing-tutorial-mocking-objects
http://www.slideshare.net/bgesiak/everything-you-never-wanted
https://www.natashatherobot.com/ios-testing-view-controllers-swift/
https://www.natashatherobot.com/unit-testing-swift-dependency-injection/
http://www.slideshare.net/bgesiak/quick-better-tests-with-incremental-setup
https://www.bignerdranch.com/blog/ui-testing-in-xcode-7-part-1-ui-testing-gotchas/
https://www.objc.io/issues/15-testing/dependency-injection/
http://masilotti.com/better-swift-unit-testing/
https://sharpfivesoftware.com/2015/02/03/testing-singletons-in-swift/
http://stackoverflow.com/questions/28115991/inject-mock-class-into-method-to-unit-test-method


