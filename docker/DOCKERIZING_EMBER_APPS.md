# "Dockerizing" Ember (and other client-side Javascript) apps

Yeah, you didn't knew this can be done...

The primary use for dockerizing javascript client apps is to allow it to run on
a normalized environment. Installing node is easy this days... but having a project
that compiles & runs *THE SAME WAY* across different systems *ON YOUR FIRST ATTEMPT*
must have a definite value... I actually end up developing these apps without Docker,
but having this as a fallback feels good.

# Caveats
* On OSX and Windows (Which run Docker on virtual hosts), features such as "file change watchers" / autocompilation / etc will just not work (as far as I know).

## TD;RL

On your ember (or angular, etc) project folder, add, remove or consider these changes:
* `docker-compose.yml`: Declare all the project services as containers:
  * a 'app' container, which starts your app's ember-cli server.
  * consider adding your backend containers, in order for the app to run without a backend deployed on the internet - You'll need the backend team to be actively building and updating development Docker images.
* `dev-entrypoint.sh`: Add this script, which should run "check or setup" tasks every time the app container is started. See [sample-entrypoint.sh](./sample-entrypoint.sh).
* `dev.env`: Add & Git-ignore this dotenv file, with sensitive data such as API keys/secrets.
* `dev.template.env`: Add this dotenv file that serves as a template for the previous file *with sensitive data replaced with 'SOME_VALUE'*

## Step by step details & things you should know
### 1: The `docker-compose.yml` file
### 4: The `dev-entrypoint.sh` file
### 5: The `dev.template.env` file

## Common literature you'll find today, and how this approach differs
I challenge you to find literature about this...
