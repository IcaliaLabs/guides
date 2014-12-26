# Database Sync

In order to keep the staging and production databases on sync, you can just follow this steps. But before:

## Pre requisites

You must have the `pgbackups` add-on enabled on heroku for both, the staging and production apps:

```console
$ heroku addons:add pgbackups --app PRODUCTION_APP_NAME
$ heroku addons:add pgbackups --app STAGING_APP_NAME
```

## Synchronization

Now in order to synchronize the databases you need to capture a database clip through the `pgbackups` add-on:

First you need to capture the prodution one:

```console
$ heroku pgbackups:capture --expire --app YOUR_PRODUCTION_APP_NAME
```

Then restore the staging database with the production database:

```console
$ heroku pgbackups:restore DATABASE `heroku pgbackups:url --app PRODUCTION_APP_NAME` \ --app STAGING_APP_NAME --confirm STAGING_APP_NAME
```

To make things easy, you can put both commands on a `database_sync.sh` file under the `script/` directory, the complete file should look like:

**script/database_sync.sh**

```
heroku pgbackups:capture --expire --app YOUR_PRODUCTION_APP_NAME
heroku pgbackups:restore DATABASE `heroku pgbackups:url --app PRODUCTION_APP_NAME` \ --app STAGING_APP_NAME --confirm STAGING_APP_NAME
```

So each time you want to sync the databases, you just need to run:

```
$ heroku run bash scripts/database_sync.sh
```

## Adding a scheduler

We like to automate everything, and to keep the databases on sync we use scheduler to achieve this.

First we need to add the [scheduler](https://addons.heroku.com/scheduler) add-on to the `production` app

```
$ heroku addons:add scheduler --app PRODUCTION_APP_NAME
```

And then on the scheduler page, just add a command to run daily like so:

![Database Sync](https://raw.githubusercontent.com/IcaliaLabs/icalia_guides/master/git/scheduler.png)

So now you have a daily synchronization to keep the staging app up to date with the production.
