# Database Sync

In order to keep the staging and production databases in sync, just follow these steps.

## Synchronization

You can copy the production app's data to the staging app's database with this command:

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
