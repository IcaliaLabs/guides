# Javascript

This is a guide to write beautiful JS code for anytime. When working with javascript try to follow this simple rules:

* Use camelcase for method/variable naming
* Never use global variables
* Encapsulate logic in classes, as they are easier to test. Use syntax transpiler for this, such as [babel](http://babeljs.io/).
* Use underscore at the beginning for private methods naming
* Prefer to isolate javascript code on individual files
* Prefer not to use the script tag on HTML for inline javascript code

## Code Review

There are simple guidelines when providing code review to a teammate. The most particular are:

* Review for bad variable names
* Review bad class definition
* Review for class names
* Review for correct dependencies invocation
* Review for specs
