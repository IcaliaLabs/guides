# Ruby

This is the guide to write beautiful Ruby code for your next project.

## Set up the laptop

You can easily set up your laptop by running [kaishi](https://github.com/IcaliaLabs/kaishi), a shell script to convert any Mac OS X or Linux computer into a real development machine. We use [rbenv](https://github.com/sstephenson/rbenv) to handle multiple ruby versions.

## Creating a gem

You want to create a `gem`, you can easily do so by following the next steps:

```console
$ bundle gem <your_gem_name>
```

This will set you up to start creating a new `gem`.

**Before naming your gem, check [RubyGems](https://rubygems.org/) to make sure that your preferred name is not already taken.**

## Code Review

There are simple guidelines when providing code review to a teammate. In particular remember to:

* Check that class names make sense
* Check for correct namespacing through `Modules`
* Review any classes longer than 100 lines
* Review any methods longer than 5 lines
* Check for if statements that are too deep (3 or more levels)
* Review specs
* Use a tool like [SimpleCov](https://github.com/colszowka/simplecov) to quickly visualize your test coverage
* Check out a style guide. Some style guides are: 
  * [AirBnB](https://github.com/airbnb/ruby)
  * [Bozhidar Batsov](https://github.com/bbatsov/ruby-style-guide)
  * [thoughtbot](https://github.com/thoughtbot/guides/tree/master/style/ruby).
  * And of course we have our [own](https://github.com/IcaliaLabs/icalia_guides/blob/master/ruby/CODE_CONVENTION.md)
* Adhere to Ruby community styles using [rubocop](https://github.com/bbatsov/rubocop) or similar
