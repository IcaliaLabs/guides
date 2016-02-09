# Javascript

This is a guide to having your TDD enviroment working on your laptop. For this you will need to have certain tool ready to be used.
Mocha allows you to use any assertion library you want, if it throws an error, it will work! This means you can utilize various libraries. We will use Chai in this case but is up to you to decide.

- [Mocha](https://mochajs.org)
  - [Chai](http://chaijs.com)

## Mocha

### Instalation

To install, just run thsi coomands with npm:
```console
$ npm install -g mocha

$ npm install chai
```

### Assertion Styles

The test creating can be done with some of the following examples:

***Assert***
```console
var assert = require('chai').assert
  , foo = 'bar'
  , beverages = { tea: [ 'chai', 'matcha', 'oolong' ] };

assert.typeOf(foo, 'string'); // without optional message
assert.typeOf(foo, 'string', 'foo is a string'); // with optional message
assert.equal(foo, 'bar', 'foo equal `bar`');
assert.lengthOf(foo, 3, 'foo`s value has a length of 3');
assert.lengthOf(beverages.tea, 3, 'beverages has 3 types of tea');
```

***Expect***
```console
var expect = require('chai').expect
  , foo = 'bar'
  , beverages = { tea: [ 'chai', 'matcha', 'oolong' ] };

expect(foo).to.be.a('string');
expect(foo).to.equal('bar');
expect(foo).to.have.length(3);
expect(beverages).to.have.property('tea').with.length(3);
```

***Should***
```console
var should = require('chai').should() //actually call the function
  , foo = 'bar'
  , beverages = { tea: [ 'chai', 'matcha', 'oolong' ] };

foo.should.be.a('string');
foo.should.equal('bar');
foo.should.have.length(3);
beverages.should.have.property('tea').with.length(3);
```

Provided you assigned should to a var, you have access to several quick helpers to keep you out of trouble when using should.

- should.exist
- should.not.exist
- should.equal
- should.not.equal
- should.Throw
- should.not.Throw

**Testing**

For testing you just need to run this command on the console.

```console
$ mocha
```
