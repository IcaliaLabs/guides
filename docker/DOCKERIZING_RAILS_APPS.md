# "Dockerizing" Rails applications for development

## TD;RL

(By "app" containers, we mean the ones running your project's code)

*You should check for your app - and avoid if possible - making queries, etc to dependent services / databases upon starting up.*

On your ruby (on-rails, sinatra) project folder, add, remove or consider these changes:
* `config/`: Remove database.yml and secrets.yml files. See [2: The (absence of) `config/database.yml` file](#2-the-absence-of-configdatabaseyml-file) and [3: The (absence of) `config/secrets.yml` file](#3-the-absence-of-configsecretsyml-file)
* `db/dumps/README.md`: Document the processes for dumping and restoring the project's database.
* `docker-compose.yml`: Declare all the project services as containers:
  * database(postgres, mysql, mongodb), keyval(redis), queue(rabbitmq), and all other generic services your app uses.
  * a 'gems' "run once" app container, which contains all libraries, common configuration, etc for the rest of the app containers.
  * a 'web' app container, which starts the web process (rails, sinatra, etc)
  * consider adding other app containers, if they apply. See [1: The `docker-compose.yml` file](#1-the-docker-composeyml-file)
* `dev-entrypoint.sh`: Add this script, which should run "check or setup" tasks every time an app container is started. See [sample-entrypoint.sh](./sample-entrypoint.sh).
* `dev.env`: Add & Git-ignore this dotenv file, with sensitive data such as API keys/secrets.
* `dev.template.env`: Add this dotenv file that serves as a template for the previous file *with sensitive data replaced with 'SOME_VALUE'*
* `dev.Dockerfile`: (if applies*) - the docker image source code to build your app base image whenever you need to install special dependencies. This can be avoided with an efficient entrypoint script.
* `.gitignore`: Add some artifacts & stuff to the ignore file.

## Step by step details & things you should know
### 1: The `docker-compose.yml` file
### 2: The (absence of) `config/database.yml` file
### 3: The (absence of) `config/secrets.yml` file
### 4: The `dev-entrypoint.sh` file
### 5: The `dev.template.env` file

## Common literature you'll find today, and how this approach differs

### 1: About having a Dockerfile with the dependency install routines VS our dev-entrypoint.sh script.
