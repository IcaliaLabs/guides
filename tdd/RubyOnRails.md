# Ruby On Rails

This is a guide to having your TDD enviroment working on your laptop. For this you will need to have certain tool ready to be used.

- RSpec
- FactoryGirl
- Fakker
- DatabaseCleaner

Here at [@icalialabs](http://icalialabs.com), we use [Platter](https://github.com/IcaliaLabs/platter) to create rails app with the basic setup.

**Platter needs ruby 2.2.3 in order to run**

Run

```console
% gem install platter
```

Use

```console
% platter yourNewRailsApp
```

It will also:

1. Setup the testing environment with Rspec, FactoryGirl, DatabaseCleaner.
2. Setup an staging environment to deploy to this environment
3. Provides the necessary configuration for the PUMA server run with Foreman
4. A setup script for new developers
5. Adds configuration for ActiveJob and DelayedJob
6. In case of an API, it will add Versionist and ActiveModelSerializers, along with a version 1 structure.
7. Adds configuration for ActionMailer to run with Sendgrid
8. Setup the project with git providing an initial commit


## Factory Girl

Platter already adds the gem to you GemFile to be ready to use.

```ruby
gem 'factory_girl'
```

### Definning Factories

Each factory has a name and a set of attributes. The name is used to guess the class of the object by default, but it's possible to explicitly specify it:

```ruby
# This will guess the User class
FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    admin false
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    first_name "Admin"
    last_name  "User"
    admin      true
  end
end
```

Using factories
---------------

factory\_girl supports several different build strategies: build, create, attributes\_for and build\_stubbed:

```ruby
# Returns a User instance that's not saved
user = build(:user)

# Returns a saved User instance
user = create(:user)

# Returns a hash of attributes that can be used to build a User instance
attrs = attributes_for(:user)

# Returns an object with all defined attributes stubbed out
stub = build_stubbed(:user)

# Passing a block to any of the methods above will yield the return object
create(:user) do |user|
  user.posts.create(attributes_for(:post))
end
```

Reffer to [Factory Girl](https://github.com/thoughtbot/factory_girl) for more details in its use.

## FFaker 

Platter already adds [FFaker](http://rubygems.org/gems/ffaker) gem to the GemFile so it can be used.

### Usage

```ruby
require 'ffaker'

FFaker::Name.name       #=> "Christophe Bartell"
FFaker::Internet.email  #=> "kirsten.greenholt@corkeryfisher.info"
```

FFaker solely purpose, is to fill up fields of data saving the developers time doing it so. [FFaker reference](https://github.com/ffaker/ffaker/blob/master/REFERENCE.md)

## Database Cleaner

Platter al well adds [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner) gem to the GemFile so it can be used.

### How to use

```ruby
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

# then, whenever you need to clean the DB
DatabaseCleaner.clean
```

With the `:truncation` strategy you can also pass in options, for example:

```ruby
DatabaseCleaner.strategy = :truncation, {:only => %w[widgets dogs some_other_table]}
```

```ruby
DatabaseCleaner.strategy = :truncation, {:except => %w[widgets]}
```


### RSpec Example

```ruby
RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end
```
## Do's and Dont's of Testing

There are a few things to keep in mind, but overall if you trust your tests and allow them to guide your development you will not go wrong.

Dos:
-Write your tests first
-Use contexts
-Use shared example groups
-Test your edge cases

Don’ts:
-Test the framework
-Test the implementation

## Sample Guide Tests:

#### Describe your methods

**BAD**
```ruby
describe 'the authenticate method for User' do
describe 'if the user is an admin' do
```

**GOOD**
```ruby
describe '.authenticate' do
describe '#admin?' do
```

#### Use contexts

**BAD**
```ruby
it 'has 200 status code if logged in' do
  expect(response).to respond_with 200
end
it 'has 401 status code if not logged in' do
  expect(response).to respond_with 401
end
```

**GOOD**
```ruby
context 'when logged in' do
  it { is_expected.to respond_with 200 }
end
context 'when logged out' do
  it { is_expected.to respond_with 401 }
end
```

#### Use factories and not fixtures

**BAD**
```ruby
user = User.create(
  name: 'Genoveffa',
  surname: 'Piccolina',
  city: 'Billyville',
  birth: '17 Agoust 1982',
  active: true
)
```

**GOOD**
```ruby
user = FactoryGirl.create :user
```

# Runnin tests

**For a specific file**
```console
% rspec path/to/spec/file.rb
```

**For all files in path**
```console
% rspec path/to/spec/
```

### For more info an examples, take a look at:

[Test Ruby with Rspec](http://cjbrock.github.io/blog/2012/10/16/testing-in-ruby-with-rspec/)

[Good/Bad Tests](http://betterspecs.org)

Also, fell free to take a look at Thoughbot [How We Test Rails Applications](https://robots.thoughtbot.com/how-we-test-rails-applications) for more about testing Rails applications.
