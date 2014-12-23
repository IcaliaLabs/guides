# Coffeescript

We are javascript lovers, but we als love the simplicity that coffeescript give us. Here is a small guide on how to  make your `coffeescript` more shiny.

* Use camelcase for method/variable naming
* Never use global variables
* Encapsulate logic in classes, as they are easier to test
* Use fat arrows when defining class methods
* Use underscore at the beginning for private methods naming

## Set up the laptop

You can easily set up your laptop by running [kaishi](https://github.com/IcaliaLabs/kaishi), a shell script to convert any Mac OS X or Linux computer into a real development machine. This will instal `npm` which is a package manager for node and makes it really easy to install libraries.

Then to install `coffeescript` you simply run:

```console
$ npm install -g coffee-script
```

We have put together a set up for happy front end development. Head to [https://github.com/IcaliaLabs/isaki](https://github.com/IcaliaLabs/isaki) and follow the instructions on how to install it and run it.

Having problems?, head over to the leader of your project and ask for help or if you find you can solve it and probably place a pull request you are welcome.

## Code Review

There are simple guidelines when providing code review to a teammate. The most particular are:

* Review for bad variable names
* Review bad class definition
* Review for class names
* Review for correct dependencies invocation
* Review for specs

