# Ruby

This is the guide to write beautiful Ruby code for your next project.

## Set up the laptop

You can easily set up your laptop by running [kaishi](https://github.com/IcaliaLabs/kaishi), a shell script to convert any Mac OS X or Linux computer into a real development machine. We use [rbenv](https://github.com/sstephenson/rbenv) to handle multiple ruby versions.

## Creating a gem

If your intention is to create a `gem`, you can easily do so by following the next steps:

```console
$ bundle gem <your_gem_name>
```

This will set you up to start creating a new `gem`.

**Be aware of using a name that is not already taken, you might run into problems later.**

## Code Review

There are simple guidelines when providing code review to a teammate. The most particular are:

* Review that class names make sense
* Review for correct namespacing through `Modules`
* Review for classes longer than 100 lines
* Review for methods longer thatn 5 lines
* Review for too deep if statements (3 or more levels)
* Review for specs