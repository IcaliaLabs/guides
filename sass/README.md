# Sass
===

For code convention check out the [CODE_CONVENTION]() file.

## Installing Compass
===

When working with Sass we always include [compass] no matter if it's a Rails project or a static page. Compass help us to produce more code with less effort and in less time thanks to the huge amount of mixins and placeholders it has.

The installation is pretty easy, just open de terminal and run:

```
$ gem update --system
$ gem install compass
```

That's it for installation, and now to start a new project using `compass`

```
$ compass create <myproject>
```

If you find it hard to work with this, we have put together a set up for happy front end development. Head to [https://github.com/IcaliaLabs/isaki](https://github.com/IcaliaLabs/isaki) and follow the instructions on how to install it and run it.

Having problems?, head over to the leader of your project and ask for help or if you find you can solve it and probably place a pull request you are welcome.

## Directory structure
===

This structure applies for a Rails project and for a static site:

```
 - assets
 		|_ stylesheets
 		 |_ application.scss
 		 |_ _buttons.scss
 		 |_ _fonts.scss
 		 |_ _tables.scss
 		 |_ _mixins.scss
 		 |_ _placeholders.scss
 		 |_ _base.scss
 		 |_ _navigation.scss
 		 |_ _variables.scss
 		 |_ _shame.scss
```

In this case every file should be called from the `application.scss` manifest like so:

**application.scss**

```scss
// Vendor libraries
@import "compass";

//Homemade dependencies
@import "variables";
@import "mixins";
@import "placeholders";

//Homemade styles
@import "base";
@import "fonts";
@import "buttons";
@import "navigation";
@import "tables";

@import "_shame";
```

If you take a good look on the order of the files invocations, you will notice that we first call all the dependencies we authored, so we have access later on the project, then the styles for the app, and lastly a `_shame.scss` file which intention is to add hot fixes and move them where they make sense as the project grows.



## Code Review
===

There are simple guidelines when providing code review to a teammate. The most particular are:

* Review for placeholder oportunities
* Review refactor on vendor prefixes css
* Check that variable names make sense
* Review for excess of nesting
* Review for class names
* Check there is no styling by id



