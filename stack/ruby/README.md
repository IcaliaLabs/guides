# Ruby

This is the guide to write beautiful Ruby code for your next project.

## Set up the laptop

You can easily set up your laptop by running [kaishi](https://github.com/IcaliaLabs/kaishi), a shell script to convert any Mac OS X or Linux computer into a real development machine. We use [rbenv](https://github.com/sstephenson/rbenv) to handle multiple ruby versions.

You can always realy on docker as well to easily test other ruby version without mess up your system. For more information on guides for docker you can go [here](../docker).

## Creating a gem

You can easily create a `gem`- by following the next steps:

```console
$ bundle gem <your_gem_name>
```

This will set you up to start creating a new `gem`.

**Before naming your gem, check [RubyGems](https://rubygems.org/) to make sure that your preferred name is not already taken.**

## Code Review

There are simple guidelines when providing code review to a teammate. In particular remember to:

* Make sure the repository is no lower than 3.5 GP on [CodeClimate](https://codeclimate.com)
* Be kind when reviewing code
* Appreciate the feedback a teammate provide 
* Check that class names make sense
* Check for correct namespacing through `Modules`
* Review any classes longer than 100 lines
* Review any methods longer than 5 lines
* Check for if statements that are too deep (3 or more levels)
* Follow the best practices - [Best Practices](BEST_PRACTICES.md)
* Adhere to Ruby community styles using:
	* [rubocop](https://github.com/bbatsov/rubocop)
	* [reek](https://github.com/troessner/reek)