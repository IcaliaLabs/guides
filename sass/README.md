# Icalia CSS/Sass Styleguide

A mostly reasonable Icalia approach to build projects using sass and css for a better architecture and maintainability.


# Table of Contents
1. General Principles
2. Glossary & Terminology
3. Commenting
4. Specificity
5. CSS Formatting
6. CSS Extras
7. Declaration order
8. Good Practices
  - Values
  - Colors
  - Media Queries
8. SCSS
  - Directory structure
  - Variable naming
  - Order
  - Nesting
  - Nested Pseudo Classes and Pseudo Elements Next
  - Use ampersand helper to attach classes
  - SASS Extras

## General Principles
- All code should semantic and readreadable for all the team.
- Don't try to overthink and optimize the code too much, instead keep it readable and understandable and easy to extend.
- Define a Pattern and Architecture before start coding.
- Break down complex components until they are made up of simple components.
- If you make a fix don't feel ashamed, instead comment the hot fix and refactor later.
- Pair with other Front End and make code reviews often.


## Glossary & Terminology

### What means a Rule Declaration?

A “rule declaration” is the name given to a selector with a group of properties inside, Example os a single rule:

``` css
.element {  
  width: 100%;
  background: #fff;
}
```

### What means a Selector?

Selectors are the element in the DOM 
Selectors are patterns used to select the DOM element(s) you want to style.  Selectors can match HTML elements, as well as an element's class, ID, or any of its attributes. Here are some examples of selectors:

``` css
.select-class {
  /* ... */
}

select-id {
  /* ... */
}

section {
  
}

[class*="col-"] {
  /* ... */
}
```

### Properties

Properties are what give the selected elements their style. Properties are key-value pairs, and a rule declaration can contain one or more property declarations. Property declarations look like this:

``` css
.something {
  background: #f1f1f1;
  color: #333;
}
```

## Commenting

### Start your document with our super fantastic Icalia's header:

Make the people know that Icalia are involved in the project using this header in your base style document:

``` css
/*  ################################################*/
/*      _            ___          __      __        */
/*    (_)________ _/ (_)___ _   / /___ _/ /_  _____ */
/*   / / ___/ __ `/ / / __ `/  / / __ `/ __ \/ ___/ */
/*  / / /__/ /_/ / / / /_/ /  / / /_/ / /_/ (__  )  */
/* /_/\___/\__,_/_/_/\__,_/  /_/\__,_/_.___/____/   */
/* #################################################*/
/* ##### Site created by www.icalialabs.com ########*/
/* #################################################*/
```

###Separate your code into logical sections using this headers:

``` css
/* ---------- Imports ----------- */
```


###Leave side annotations to clarify fixed or funny values:

``` css
.header {
  top: 22px; /* Top between header and body */
}

.header {
  z-index: 123px; /* Needs fixes */
}
```


## Specificity

To maintain a better code and avoid styles overrides you might follow the next rules:

### Don't: Reference or style descendent elements in yourclass selectors.

**Bad**

```css 
.post h1 {
    ...
}
```

Instead use a custom class so your element does not depend on the HTML tag.

**Good**

``` css
.post .post__title {
  ....
}
```

Later you can use Sass to nest the styles.

### Don't: Use overqualified selectors in your CSS. Do not prepend a general class or ID with an element.

**Bad**

``` css
section.container {
    ...
}
```


## CSS Formatting

### Use dashes over camelCasing in class name:**

**Bad**

``` css
.avatarDefault {
    /* ... */
}
```

**Good**

``` css
.avatar-default {
    /* ... */
}
```

### Don't use ID selectors to style.
Note: In some cases when you use one-page navigation or uses javascript you can use ID for that, but not for styling, instead use a class.

``` html
<section class="section hero work" id="work">
```

When using multiple selectors in a rule declaration, give each selector its own line.


 **Bad**
 
``` css
.no, .nope, .not_good {
    // ...
}
```

**Good**

``` css
.one,
.selector,
.per-line {
  // ...
}
```

## CSS Extras

- Put a space before the opening brace `{` in rule declarations
- In properties, put a space after, but not before, the `:` character.
- Put closing braces `}` of rule declarations on a new line.
- Put blank lines between rule declarations.
- Abstain from using `!important`
- Use soft tabs (2 spaces) for indentation
- Lowercase all hex values, e.g., `#fff` lowercase letters are much easier to discern when scanning a document as they tend to have more unique shapes.
- Use shorthand hex values where available, e.g., `#fff` instead of `#ffffff`.
- Don't include spaces after commas within `rgb()`, `rgba()`, `hsl()`, `hsla()`, or `rect()` values. This helps differentiate multiple color values (comma, no space) from multiple property values (comma with space).
- Avoid specifying units for zero values, e.g., `margin: 0;` instead of `margin: 0px;`.
- Use a leading zero in decimal numbers: 0.5 not .5

## Declaration order

Although not important to be strict with this rule it's a good practice order your properties in the next order:

1. Positioning
1. Box model
1. Typographic
1. Visual

**Positions** comes first because it can remove an element from the normal flow of the document and break the layout.
**Box model** comes next as it dictates a component's dimensions and placement.

When you are using Sass see the order structure for sass projects.

``` css
.declaration-order {
  /* Positioning */
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 100;

  /* Box-model */
  display: block;
  float: right;
  width: 100px;
  height: 100px;

  /* Typography */
  font-family: 'Open Sans', sans-serif;
  line-height: 1.5em;
  color: #333;
  text-align: center;

  /* Visual */
  background: #f5f5f5;
  border: 1px solid #e5e5e5;
  border-radius: 3px;

  /* Misc */
  opacity: 1;
}
```

### Prefixed properties

When uses prefixed must be ordered in the next order:

``` css
/* Prefixed properties */
.selector {
  -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
          box-shadow: 0 1px 2px rgba(0,0,0,.15);
}
```

## Values

### Try to don't specify the height of an element, instead use top and bottom padding or min-height.

**Bad** 

``` css
.section {
  height: 200px;
  ...
}
```

**Good**

``` css
.section {
  min-height: 100px;
  padding: 50px 0px;
}
```

### Use ems or rem in all your pixels values.
You can use the formula: `a/b = c` where `a`is your desired value, `b` is your `font-size` base and `c`it's your `em`or `rem` final value.

If you use sass you can use a function.

### Use percentages only in width related properties, avoid in height related properties.

**Good**

```css
  .module {
    width: 50%;
    margin-right; 50%;
  }
```

**Bad**

```css
  .title-section {
    height: 22%;
  }
```

### Use vh and vw to screen based dimentions:

When an element needs to keep a proportional dimention based on the screen use `vh` or `vw`values:

``` css
  .full-page {
    height: 100vh;
  }
```

and you might use an fallback in px or percetage:

``` css
  .full-page {
    height: 768px;
    height: 100vh;
  }
```

## Colors
For colors use ´hex´ codes or ´rgba´ values.

When you need an translucent color, `box-shadow` or `text-shadow` property use `rgba` to make a color transparent, never use ´opacit´.

**Bad**

``` css
  .modal-bg {
    background-color: #000;
    opacity: 0.5;
  }
```

**Good**
``` css
  .modal-bg {
    background-color: rgba(0,0,0,0.5);
  }
```

## SASS

- For SCSS using Rails
- For SCSS using Gulp
- For SCSS using React

Files (CSS) Architecture is one of the most important and critical part of the markup development.
We try to use a mix of css architecture methodologies: **BEM** and **OCSS**, in the next points we explain the architecture:

### Directory structure

```
- Styleguide
 |_ base.scss
 |_ _reset.scss
 |_ _typography.scss
 |_ _mixins.scss
 |_ _utilities.scss
 |_ _placeholders.scss
 |- layout
  |_ _navigation.scss
  |_ _footer.scss
 |- page
  |_ _page.scss
 |_ _variables.scss
 |_ _grid.scss
```

In this case every file should be called from the application.scss manifest like so:

``` css
//Project dependencies
@import "reset";
@import "variables";
@import "mixins";
@import "placeholders";

//General styles
@import "typography";
@import "utilities";
@import "grid";
@import "tables";

//Pages styles
@import "layout/navigation";
@import "layout/footer";

@import "page/page";
```

### Variable naming

When comes to naming variables, it may be hard to find the correct name for it, at Icalia Labs we the variable names to be related to the behavior or purpose of the variable and not the color or style.

This is because when you have a variable called (e.g. `$orange`) you suddenly realized you need to change that to a blue color, and the variable name does not make sense with the value it is holding.

**Good**

`$primary-color: #191818;`

**Bad**

`$blue: blue;`

Also attempt to use !default flag to the end of the value, so if the variable has already been assigned to, it won’t be re-assigned, but if it doesn’t have a value yet, it will be given one.

`$brand-font: 'Open Sans', sans-serif !default;`

Adopt useful conventions

Use prefixes and postfixes to order and categorize your variables and have a better context for them.

For example, you can postfix color names with ´-color:´

``` css
// Base colors
$base-color: #333;
$brand-color: #1ca5fc;
$brand-50-color: rgba($color-brand, 0.5);
$accent-color: #ffeb3b;
```

### Order

Like our normal order to properties when we use Sass the order changes to the next:

1. Placeholders, Mixins and Extends.
1. Positioning
1. Box model
1. Typographic
1. Visual

```css
.my-class {
  @extend: .other-class;
  @include border-radius(10px);
  ...
}
```

### Nesting

Mixins help us to make a better agroupation of elements using SMACSS and BEM methodologies but it's important to limit the nesting level to 2 or 3 because can generate problems with our specificty and performance guidelines.

**Bad**

``` css
.header {
  ...
  .menu {
    ...
    .nav {
      ...
      a {
        ...
        .active {
          ....
        }
      }
    }
  }
  ..
}
```

**Good**

```css
.header {
  ...
  &.is-active {
    ...
  }
}

.menu {
  ...
}

.nav {
  ...
  a {
    ....
  }
}
```

### Nested Pseudo Classes and Pseudo Elements Next

Use the ampersand `&`helper to use Pseudo Selectors

```csss
.button {
  ....
  &:hover {
    background: $color;
  }
  &:active {
  background: $other-color;
  }
  ...
}
```

### Use ampersand helper to attach classes
Use the ampersand `&`helper to create a "moddule constructor" or define actions.

**Constructor use**

``` css
  .section__title {
    ...
    &.small {
      font-size: 2em;
    }
    
    &.big {
      font-size: 3em;
    }
  }
```

**Actions**

```css
  .header {
    ..
    
    &.is-fixed {
      ...
    }
  }
```


### SASS Extras
- Use space around operands: `$variable * 2.2`, not `$variable*2.2`
- Use a `%` unit for the amount when using Sass's color functions: `lighten($color, 30%), not lighten($color, 30)`
- Use `//` for comment blocks not `/* */`.
- Never Write Vendor Prefixes, you can use @mixins provided by libraries like Compass or use Autroprefixer to them.
- Break Into As Many Small Files As Makes Sense
- Partials are named _partial.scss
- In Deployment, Compile Compressed
- Don't Even Commit .css Files
- Be Generous With Comments
- Partials are named _partial.scss