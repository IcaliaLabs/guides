# Swift

This guide is built to share the best practices in writing swift code.

- [Fundamentals](#fundamentals)
- [Swift style guide](#swift-style-guide)
- [Api Client Setup](#api-client-setup)
- [Project structure for MVC](#project-structure-for-mvc)
- [Swiftlint](#swiftlint)
- [Pod installations](#pod-installations)

## Fundamentals

  * Use english to code.
  * Use camel case. For example:
    ```swift
      let isCorrect: Bool
    ```
  * Use descriptive descriptive, clarity is more important than brevity. For example:
    ```swift
      let isFriday: Bool {}
      if isFriday {
        print("Friday!!!!")
      }
    ```  

## Swift style guide

  * https://swift.org/documentation/api-design-guidelines/
  * https://github.com/raywenderlich/swift-style-guide


## Api Client Setup

  Many IOS applications use external Api, this is a setup which might come useful.

  * This setup uses a singleton class, ApiClient in which the api methods are written.

  ```swift
    class ApiClient {
        static let shared = ApiClient()
      ...
    }

  ```
  * Its also useful to divide the url endpoints to the base url

  ```swift
    enum Endpoints {
    case .getNames
     ...  
    }
  ```

  * The methods use completion handlers. Something like this:

  ```swift
     func getNames(completion: @escaping (Result(T))) {
       ...
       if error != nil {
           completion(.error)
       } else {
         completion(.success(names))
       }
     }
  ```

## Project structure for MVC

  * As for folder structure, follow something like this:
    * Models
    * Views
    * Controllers
    * Others


## Swiftlint

 * Swiftlint is a tool to enforce swift style and conventions, here the  link to its github https://github.com/realm/SwiftLint/.

 * Here are the set of rules that we use:

  ```yml
    disabled_rules:
    - control_statement
    - line_length
    - trailing_whitespace
    - force_cast
    - class_delegate_protocol
    - weak_delegate

    opt_in_rules:
    - empty_count

    excluded:
    - Pods

    vertical_whitespace:
    max_empty_lines: 2

    file_length:
    warning: 500
    error: 1000
  ```

## Pod installations  

  * [CocoaPods](https://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects. It has over 40 thousand libraries and is used in over 2.8 million apps. CocoaPods can help you scale your projects elegantly. (Taken from https://cocoapods.org)

  * Pods of Icalia Labs:

    * [Presentr](https://github.com/IcaliaLabs/Presentr)
    * [LoginKit](https://github.com/IcaliaLabs/LoginKit)
    

  * Pods that we use in Icalia Labs:  

    * [IHKeyboardAvoiding](https://github.com/IdleHandsApps/IHKeyboardAvoiding)
    * [SideMenu](https://github.com/jonkykong/SideMenu)
