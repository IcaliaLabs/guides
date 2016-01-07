## TD;RL

(By "app" containers, we mean the ones running your project's code)

*You should check - and avoid if possible - for your app making queries, etc to dependent services / databases upon starting up.*

Your ruby (on-rails, sinatra) project:
* `app/`
* `config`
  * *no database.yml file!*
  * *no secrets.yml file!*
* `db`
  * `dumps` file directory: Contains database dumps, which should be Git-ignored.
    * `README.md`: Contains information about dumping and restoring databases.
* `docker-compose.yml` - Declares all the project containers, which image they use, etc:
  * database(postgres, mysql, mongodb), keyval(redis), queue(rabbitmq), and all other generic services your app uses.
  * a 'gems' "run once" app container, which contains all libraries, common configuration, etc for the rest of the app containers.
  * a 'web' app container, which starts the web process (rails, sinatra, etc)
  * a 'real-time' app container (if applies) which starts the websocket process.
  * a 'jobs' app container (if applies) which starts the asynchronous jobs container.
  * a 'test' app container, which run tests automatically (Guard), and can be used to run them manually.
  * a 'benchmarks' app container (optional), which runs the app in production mode, to run benchmarking tests.
* `dev-entrypoint.sh` - A script that runs setup tasks every time an app container is started. See [sample-entrypoint.sh](./sample-entrypoint.sh).
* `dev.env` - a Git-ignored dotenv file with sensitive data such as API keys/secrets.
* `dev.template.env` - a dotenv file that serves as a template for the previous file *with sensitive data replaced with 'SOME_VALUE'*
* `dev.Dockerfile` (if applies*) - the docker image source code to build your app base image whenever you need to install special dependencies. This can be avoided with an efficient entrypoint script.
* `.gitignore` - add some artifacts & stuff to the ignore file.

## 1: The (absence of) `config/database.yml` file
## 2: The (absence of) `config/secrets.yml` file
## 3: The `docker-compose.yml` file
## 4: The `dev-entrypoint.sh` file
## 5: The `dev.template.env` file
