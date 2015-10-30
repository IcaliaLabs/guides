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

#### Set up the needed Buildpack
Add the [Heroku Toolbelt](https://github.com/gregburek/heroku-buildpack-toolbelt). Before following the instructions outlined there run:
```console
$ touch .buildpacks
```
Then run the commands, starting with:
```console
 $ heroku config:add BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git --app YOUR_STAGING_APP_NAME
 ```
And ending with:
```console
$ heroku run 'vendor/heroku-toolbelt/bin/heroku auth:token' --app YOUR_REMOTE_APP_NAME
```

Check to make sure the buildpack is successfully installed by typing:
```console
$ heroku buildpacks --app YOUR_STAGING_APP_NAME
```

#### Set up the database sync file
Create a database sync file and make it executable:
```console
$ touch database_sync
$ chmod +x database_sync
```
Add the following lines into the database_sync:
```
curl -s https://s3.amazonaws.com/assets.heroku.com/heroku-client/heroku-client.tgz | tar xz
rsync -a heroku-client/* .
rmdir heroku-client
PATH="bin:$PATH"

heroku pg:copy YOUR_PRODUCTION_APP_NAME::YOUR_PRODUCTION_APP_DATABASE_COLOR YOUR_STAGING_APP_COLOR --app YOUR_STAGING_APP_NAME --confirm YOUR_STAGING_APP_NAME
```

For a real app, the last line would like something like:

`heroku pg:copy my-new-app::BRONZE BRONZE --app my-new-app-staging --confirm my-new-app-staging`

Commit all changes and push to your staging environment.

#### Set up scheduler
Add the [Heroku scheduler](https://elements.heroku.com/addons/scheduler) add-on to the **staging** app.

```console
$ heroku addons:create scheduler --app PRODUCTION_APP_NAME
```

Go to the Heroku dashboard for your staging app. At the bottom of the page, in the add-ons section, click on Heroku Scheduler. On the scheduler page, just add a command:
```
$ database_sync
```
Select the daily frequency option, and now you have a daily synchronization to keep the staging app up to date with the production.

NOTE: Heroku commands have been changing frequently. If these commands don't work check Heroku and/or Stack Overflow for the latest.
