# Code Convention

Below we haved listed some of the practices we follow for every Rails project.

## Views

* Never use local variables on views
* Refactor views by using `partials`
* Don't use instance variables on partials, use local variables instead.
* Never use instance variables for helpers. Pass local variables to the method

## Models

* Encapsulate complex queries into the models
* Choose to include the method `inverse_of` in your models to save yourself from headaches.
* Abstain from bypassing validations with methods like `save(validate: false)`, `update_attribute` or `toggle`
* Validate the associated `belongs_to object (user)`, not the database column `(user_id)`.
* Favor in use of `find` over `where` when you need to retrieve a single record (whether by id or some attributes)

## Controllers

* Try to keep your controller actions with one instance variable.
* Never instantiate more than one object on a controller
* Keep the controllers skinny they shouldn't contain any business logic 

## Migrations

* Name your migrations to start with a verb `AddEmailToUsers`
* Set the default value to an empty string on non-required strings and text types
* Default values should be declared on the migrations not the models.

## Routes

* Avoid nest routes more than one level deep (they can quickly become cumbersome). If you don't have any other option you can use [shallow](http://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing) nesting to evade deep nesting

## Misc

* Choose `decorators` over `helpers` when your project is likely to widen
* Choose `Date.current` over `Date.today`
* Try to keep your classes no more than 100 lines long
* Try to keep your methods no more than 5 lines long
* Use the `_url` suffix for email templates routes and redirects. Otherwise use the `_path` suffix.
* Keep the `db/seed` always with up to date data to run the project.
