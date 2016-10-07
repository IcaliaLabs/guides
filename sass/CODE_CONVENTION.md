# Code Convention

CSS architecture is one of the most complex an critical things in the early stage of the project, it's important to determine and understand how to project needs to be structured.


Below we haved listed some of the statements you might follow:

* Use consistent indentation [Default: 2 spaces]
* Always use lowecase

* Use well aligned open/closing brackets
* Never write multiple rules per line
* Write the rules on alphabetical order
* Never style with #ID's
* Abstain from using `!important`
* Try not to go to deep on nesting, probably 3 or 4 levels might be enough
* Break into as many files as makes sense
* Use variables for colors
* Abstain of using `mixins` without parameters, instead use `placeholders`


## Listing rules

**List @extend(s) and @mixin(s) first**

```scss
.button {
	@extend %button;
  @include border-radius(2px);
  ...
}
```

**List "Regular" styles ordered alphabetically next**

```scss
.button {
	@extend %button;
	background: #000000;
	margin: 0;
	padding: 0;
}
```

**Nested selectors last**

```scss
.button {
	@extend %button;
	background: #000000;
	margin: 0;
	padding: 0;
	@include border-radius(2px);
	
	> small {
		font-size: 10px;
	}
}
```

## Variable naming

When comes to naming variables, it may be hard to find the correct name for it, at Icalia Labs we the variable names to be related to the behavior or purpose of the variable and not the color or style.

This is because when you have a variable called `$orange` you suddenly realized you need to change that to a blue color, and the variable name does not make sense with the value it is holding.

A good example would be:

```
$primary-color: #191818;
$secundary-color: lighten($primary-color);

$navigation-background-color: darken($primary-color);

$button-primary-background-color: $primary-color;
```

A bad example would be:

```
$blue: blue;
$red: red;

$navigation-background-color: darken($red);

$button-primary-background-color: $blue;
```

A really cool live project using this is [Furatto](http://icalialabs.github.io/furatto/) check the [source code](https://github.com/IcaliaLabs/furatto/tree/v3.1.0/scss/furatto) for more on this.
