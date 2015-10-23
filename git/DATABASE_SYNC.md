# Database Sync

In order to keep the development, staging and production databases in sync, just follow these steps.

## Synchronization

#### Copying the production app's data to the staging app's database

Type in the following command in the terminal, replacing the app names and database colors with the appropriate values. The database color can be found by looking at the Heroku dashboard for the app (in the add-on section).

```console
$ heroku pg:copy YOUR_PRODUCTION_APP_NAME::YOUR_PRODUCTION_APP_DATABASE_COLOR YOUR_STAGING_APP_DATABASE_COLOR --app YOUR_STAGING_APP_NAME
```
For example, this could look like:

```console
$ heroku pg:copy my-new-app::BRONZE BRONZE --app my-new-app-staging
```

Then confirm that you want to destroy all the staging app data by typing in the staging app name:

```console
> STAGING_APP_NAME
```

#### Replacing the local development database with a remote database (staging or production)
Sometimes it's useful to try out new features using real data; in this case it's handy to copy the remote database to your local database. This is achieved quickly with these two commands:

```console
$ dropdb YOUR_DEVELOPMENT_DATABASE_NAME
$ heroku pg:pull YOUR_REMOTE_APP_NAME YOUR_DEVELOPMENT_DATABASE_NAME --app YOUR_REMOTE_APP_NAME
```


If your app's name is "Awesome app" and you want to copy the staging database, this would look like:

```console
$ dropdb awesome_app_development;
$ heroku pg:pull HEROKU_POSTGRESQL_BRONZE awesome_app_development --app awesome_app-staging
```

## Adding a scheduler

Using a Heroku scheduler is a great way to automatically keep the staging database in sync with the production database.

First we need to add the [Heroku scheduler](https://elements.heroku.com/addons/scheduler) add-on to the **staging** app.

```
$ heroku addons:create scheduler --app PRODUCTION_APP_NAME
```

Go to the Heroku dashboard for your staging app. At the bottom of the page, in the add-ons section, click on Heroku Scheduler. On the scheduler page, just add a command to run daily like so:
```
$ heroku pg:copy YOUR_PRODUCTION_APP_NAME::YOUR_PRODUCTION_APP_DATABASE_COLOR YOUR_STAGING_APP_COLOR --app YOUR_STAGING_APP_NAME --confirm YOUR_STAGING_APP_NAME
```
So now you have a daily synchronization to keep the staging app up to date with the production.

NOTE: Heroku commands have been changing frequently. If these commands don't work check Heroku and/or Stack Overflow for the latest.
