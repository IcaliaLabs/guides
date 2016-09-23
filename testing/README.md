# TDD

Here at IcaliaLabs, we try to develop software under the TDD methodology, since it has shown its value along the procces of creating new features or fixing issues. Lets start by telling you what it is and how to start working with it.

## What is TDD?

TDD is an iterative development process where each iteration starts by writing a test which forms a part of the specification we are implementing. The short iterations allow for more instant feedback on the code we are writing, and bad design decisions are easier to catch. By writing the tests prior to any production code, good unit test coverage comes with the territory, but that is merely a welcome side-effect.

The test-driven development process is an iterative process where each iteration consists of the following four steps:

* Write a test.
* Run tests, watch the new test fail.
* Make the test pass.
* Refactor to remove duplication.

![TDD](https://leantesting-wp.s3.amazonaws.com/resources/wp-content/uploads/2015/02/tdd-circle-of-life.png)

Sometimes is hard to implement TDD, specially when working with an API or when the feature is not well defined, or not as much as we would like, each developer must be conscious of adding testing whether or not is through TDD. 

**Remember TDD is good and often leads to good code design, but what is more important is to actually have tests. Don't use TDD as an excuse to no produce tests.**

Take a look at the languaje you will be working, and follow the guides for a TDD enviroment:

* [Ruby On Rails](rails.md)