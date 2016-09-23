# Rails

This is a guide to write better Rails apps for the future.

## Set up the laptop

You can easily set up your laptop by running [kaishi](https://github.com/IcaliaLabs/kaishi), a shell script to convert any Mac OS X or Linux computer into a real development machine.

Or if you don't want all the trouble you can easily download [Docker](https://www.docker.com/products/docker) and start working right away.

## App creation

We have developed a [gem](https://github.com/IcaliaLabs/platter) to help you configure the rails application with all the tools we use to develop applications.

To install it just run:

```
% gem install platter
```
## Setting up the app

We created a [how-to wiki article]() for you to follow and setup the application.

If for some reason you find it hard to run it or something is missing about the app, talk to the project manager about the issue.

## Tracking && Developing

We love git, we use it for every single project. Check out the [Git guide](../../stack/git) for information about this.

## Code Review

There are simple guidelines when providing code review to a teammate. The most particular are:

* Review for SQL injection vulnerability
* Review index on foreign keys
* Check the migrations integrity
* Review views for excess usage of helpers or variable declaration
* Detect N+1 queries on models, and suggest to use eager loading when necessary

We also try our best to follow these [best practices](BEST_PRACTICES.md)

## Deployment

It is important that you always deploy from the master of your local computer to the production environment on Heroku. To see more about new feature branches and staging environment, checkout the [git guide](https://github.com/IcaliaLabs/icalia_guides/tree/master/git).

##### Deployment checklist

Whenever we are deploying an application to production for the first time, we make sure we have everything covered:

* Are we on deploying to heroku or using docker?
* Are we using Unicorn or Puma as the server? [Setup Rails server]()
* Are we using Delayed jobs for sending emails?
* Is Ruby 2.x.x defined in the Gemfile?
* Are we using Figaro to setup the environment variables? [Setup Figaro](https://github.com/laserlemon/figaro)
* Are we saving logs through one of the providers or locally?
* Are we backing up the databases?
* Are we monitoring the application performance? [New Relic](https://devcenter.heroku.com/articles/newrelic#ruby-configuration)
* Are we tracking errors? [Exception Notification](https://github.com/smartinez87/exception_notification)
* Is the domain configured? [Domain Configuration](DOMAIN_CONFIG.md)
* Is Sendgrid/Mailgun configured for email delivering?

