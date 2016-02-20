# "Dockerizing" Rails applications Part I: Development

## 1: The rails + docker example
For a finished example, be sure to check the
[Rails Docker Demo](https://github.com/IcaliaLabs/rails-docker-demo).

## 2: The `docker-compose.yml` file, and planning your container architecture.

We *MUST* think about containers as *processes* rather than "A cheap/fast
virtual machine running lots of I don't know". This will give us the ability to
scale each process whenever it's needed, and just to the point is needed.

Taking the [Rails Docker Demo](https://github.com/IcaliaLabs/rails-docker-demo)
as an example, let's assume we have a Rails app with `sidekiq` and `actioncable`,
and with a good test suite. A great container layout (and by extension, a
`docker-compose.yml` file) for development purposes would be as follows:

* A `postgres` container serving the main database.
* A `redis` container working as a caching server and job queue storage.
* A `app_code` storage-only container, with the app code mounted from the host,
and the app gems, which will be shared to the rest of the app containers.
* A `web` container running the `rails server` command.
* A `jobs` container running the `sidekiq` command, to process the queued jobs.
* A `websocket` container, which will run `puma` along with `actioncable` to
serve websockets.
* A `test` container running `guard`, which will run tests whenever our code
changes.
* A `benchmark` container running the `rails server` command in production mode.
This will used to give us some idea about performance bottlenecks which we don't
want to run into when it's live.

## 3: Prefer using environment variables, instead of configuration files.

Most of the time, you can replace several Rails config files with environment
variables. Most of these variables can be set in the `docker-compose.yml` file,
whereas others could be set on a dotenv file:

* Use `DATABASE_URL`, and remove the `config/database.yml` file.
* Use `SECRET_KEY_BASE`, and remove the `config/secrets.yml` file.

## 4: Secrets, and the dotenv file & template.

We deffinitely want to have secrets (passwords, api keys/secrets, etc) in a
dotenv file - preferably called `dev.env`. Also, we *MUST* keep this file out of
version control, so be sure to add it to your repo's ignore rules.

However, we'll need to have some sort of template in order to easily replicate
this file. That's the purpose of the [`dev.env.example` file](https://github.com/IcaliaLabs/rails-docker-demo/blob/master/dev.env.example),
which includes sample values for developers to fill before starting the
environment.

## 5: Whereas possible, make sure your Rails app can start in isolation.

Since Docker Compose can't guarantee the start order of the containers - or the
time a container can take to accept incoming connections - the *"best
practice"* is to remove any code that queries other services on the
app start - up to whenever it's possible.

Some common culprits whenever working with Rails code:
* *Some Rails initializer querying a service (often a database) to obtain
configuration values:* this is actually a very nasty anti-pattern, creating more
problems than it solves.
* ???

## 6: The entrypoint script & command.

Whenever Docker runs a container, it uses a shell script called "entrypoint" to
invoke the given (or default) command. The default entrypoint's content is a
simple `/bin/sh -c [cmd]`.

However, customizing this entrypoint script is necessary to streamline our
development workflow, by running these tasks whenever any of our app containers
starts:

* Check or install the app dependencies with Bundler
* Check or setup the app database (more on that later)
* Attempt to fill in missing parameters on the given command

Check out the [`dev-entrypoint.sh` file](https://github.com/IcaliaLabs/rails-docker-demo/blob/master/dev-entrypoint.sh)

You'll find a lot of articles out there talking about using Docker Compose's
`build` attribute to generate a base image with the app dependencies already
installed... I *MUST* advice against it, since you'll find yourself

## 7: A `restoredb` script!


## TD;RL

(By "app" containers, we mean the ones running your project's code)

*You should check for your app - and avoid if possible - making queries, etc to dependent services / databases upon starting up.*

On your ruby (on-rails, sinatra) project folder, add, remove or consider these changes:
* `config/`: Remove database.yml and secrets.yml files. See [2: The (absence of) `config/database.yml` file](#2-the-absence-of-configdatabaseyml-file) and [3: The (absence of) `config/secrets.yml` file](#3-the-absence-of-configsecretsyml-file)
* `db/dumps/README.md`: Document the processes for dumping and restoring the project's database.
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
