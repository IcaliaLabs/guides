# Rails

This is a guide to write better Rails apps for the future.

## Set up the laptop

You can easily set up your laptop by running [kaishi](https://github.com/IcaliaLabs/kaishi), a shell script to convert any Mac OS X or Linux computer into a real development machine.


## App creation

We have developed a [script](https://github.com/IcaliaLabs/platter) to help you start your rails apps with the barebones that will accelerate your development process.

## Setting up an existing app

We use [Gitlab](https://about.gitlab.com/) to keep the source code safe and on track. So once you have your account ready, the first step is to get the code:

```
$ git clone git@gitlab.icalialabs.com:icalialabs/repo_name.git
```

Then setup the dependencies:

```
$ bundle install
```

Add the `database.yml` file and edit it to meet your credentials. Then create the database and run the migrations:

```
$ bundle exec rake db:create:all
$ bundle exec rake db:setup
```

Create an `application.yml` file under the `config` directory and copy the contents of `example_application.yml`.

You can now lift the app. 

```
$ rails server
```

If for some reason you find it hard to run it or something is missing about the app, talk to the project manager about the issue.

## Tracking && Developing

We love git, we use it for every single project. Check out the [Git guide](https://github.com/IcaliaLabs/icalia_guides/tree/master/git) for information about this.


## Code Review

There are simple guidelines when providing code review to a teammate. The most particular are:

* Review for SQL injection vulnerability
* Review index on foreign keys
* Check the migrations integrity
* Review views for excess usage of helpers or variable declaration
* Detect N+1 queries on models, and suggest to use eager loading when necessary

We also try our best to follow these [code conventions](https://github.com/IcaliaLabs/icalia_guides/blob/master/rails/CODE_CONVENTION.md)

## Deployment

It is important that you always deploy from the master of your local computer to the production environment on Heroku. To see more about new feature branches and staging environment, checkout the [git guide](https://github.com/IcaliaLabs/icalia_guides/tree/master/git).

The first step is fetch any change from the `origin` remote:

```
$ git fetch origin
$ git pull origin dev
```

Then you can merge everything on `dev` to `master`:

```
$ git checkout master
$ git merge dev
```

If necessary, add the new environment variables to Heroku, we use [Figaro](https://github.com/laserlemon/figaro) to handle this:

```
$ bundle exec figaro heroku:set -e production
```

Deploy to Heroku production

```
$ git push production master
```

If necessary, run the migrations and scripts you might have set up

```
$ heroku run rake db:migrate --remote production
$ heroku restart --remote production
```

Remember that this process only applies for hot fixes and merged features to dev, as they have been already tested on the browser.

## Setup the production environment

* Make sure you have a correct [Procfile](https://github.com/IcaliaLabs/icalia_guides/blob/master/rails/Procfile_Sample) set up and ready to run with [unicorn](https://github.com/IcaliaLabs/icalia_guides/blob/master/rails/unicorn_sample.rb)
* Make sure you have the ruby version specified on the `Gemfile`
* Make sure the PG-Backups add on is enabled
* Make sure to add a logs providers
* Make sure you have [New Relic] for app monitoring

## Deployment checklist

Whenever we are deploying an application to production for the first time, we make sure we have everything covered:

* Are we on Cedar?
* Are we using Unicorn as the server? [Setup Unicorn](https://devcenter.heroku.com/articles/rails-unicorn)
* Are we using Delayed jobs for sending emails?
* Is Ruby 2.x.x defined in the Gemfile?
* Are we using Figaro to setup the environment variables? [Setup Figaro](https://github.com/laserlemon/figaro)
* Are we saving logs in Heroku through one of the providers?
* Are we backing up the databases on Heroku?
* Are we monitoring the application performance? [New Relic](https://devcenter.heroku.com/articles/newrelic#ruby-configuration)
* Are we tracking errors? [Exception Notification](https://github.com/smartinez87/exception_notification)
* Is the domain configured? [Domain Configuration](https://github.com/IcaliaLabs/icalia_guides/blob/master/rails/DOMAIN_CONFIG.md)
* Is Sendgrid configured for email delivering?

