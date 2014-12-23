# Code Convention

Below we haved listed some of the practices we follow for every Rails project.

* Never use local variables on views
* Encapsulate complex queries into the models
* Refactor views by using `partials`
* Name your migrations to start with a verb `AddEmailToUsers`
* Set the default value to an empty string on non-required strings and text types
* Choose `decorators` over `helpers` when your project is likely to widen
* Choose to include the method `inverse_of` in your models to save yourself from headaches.
* Try to keep your controller actions with one instance variable.
* Choose `Date.current` over `Date.today`
* Never instantiate more than one object on a controller
* Never use instance variables for helpers. Pass local variables to the method
* Default values should be declared on the migrations not the models.
* Try to keep your classes no more than 100 lines long
* Try to keep your methods no more than 5 lines long
* Abstain from bypassing validations with methods like `save(validate: false)`, `update_attribute` or `toggle`
* Use the `_url` suffix for email templates routes and redirects. Otherwise use the `_path` suffix.
* Validate the associated `belongs_to object (user)`, not the database column `(user_id)`.
* Keep the `db/seed` always with up to date data to run the project.