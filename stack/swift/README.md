# Swift

This guide is built to share the best practices in writing swift code.

- [Fundamentals]()
- [Swift style guide]()
- [Api Client Setup]()
- [Project structure for MVC]()
- [Swiftlint]()
- [Pod installations]()

### Fundamentals

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

### Swift style guide

  * https://swift.org/documentation/api-design-guidelines/
  * https://github.com/raywenderlich/swift-style-guide


### Api Client Setup

  Many IOS applications use external Api, this is a setup which might come useful.

  * This setup uses a singleton class, , ApiClient in which the api methods are written.

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

  * The methods use completion handlers


### Project structure for MVC


### Swiftlint


### Pod installations  
