# Best practices

* Use snake case for variable naming
* Use metaprogramming as a last resource
* Abstain from using single line blocks when more than one thing is being done inside of it
* Declare very descriptive method names, no matter if they are long
* Don't name your classes or modules with the type on it, `SearchClass`, `VotableModule`
* Use camel case for naming your classes/modules
* Never build methods with more than 3 arguments
* Choose the syntax `{ key: value }` over `{ :key => value }` for hash
* Choose the one line syntax for `if` and `unless` from the `if/unless ... end` syntax when there is only one condition
* Abstain monkey-patching
* Abstain optional parameters
* Write self-documenting code
* Try to keep your classes as SOLID as possible
* Trust [reek](https://github.com/troessner/reek) & [rubocop](https://github.com/bbatsov/rubocop)
