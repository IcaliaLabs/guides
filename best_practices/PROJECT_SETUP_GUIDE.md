# Project Setup Guide

NOTE: Some of these steps will be automated.

## Required Files

The following are files we require all projects to have:

### Git-related files

#### Git Ignore Rules

A `.gitignore` file placed at the root of the project is required to exist, with rules to ignore:

* OS artifacts
* User-Upload media files
* Temporary files
* Database dumps
* `node_modules` folder
* Command-line history files (such as `.bash_history`, `.pry_history`

#### Git Attributes File

A `.gitattributes` file placed at the root of the project is required to exist, with Git attributes
required for the repo:

```
* text=auto

*.sh text eol=lf
```

More specifically, these rules are required to avoid developers using Windows being screwed
by Git for Windows converting file line endings on scripts used by Linux Containers, and **it's specially
important** on teams with mixed development environments. See
["The case of Windows line-ending in bash-script"](https://techblog.dorogin.com/case-of-windows-line-ending-in-bash-script-7236f056abe)

## Docker-related files:

### Docker ignore rules

In addition to the rules at the `.gitignore` file (which are expected to be present in this file as well):

* Git files and folders - such as `.gitignore`, `.git` and `.gitattributes` 
* Dockerfiles, compose files and the `.dockerignore` file

### Development Dockerfile

For the application, a file called `dev.Dockerfile` must be present, so the 
app's development container can be set up at any time.

### Development Docker Compose File

This file is used to fire up the whole stack required for development. The development stack may (should!)
include database services (Postgres, Redis, Elasticsearch, etc), storage services (like Minio), a "test"
service container (**MUST!**), a "web" service container (if applies), and possibly other services such as "jobs",
"listener", etc. A "web_benchmark" may also be included, which should start the web app in "production" mode to
test performance features and also work as a local stress testing target.

### Deployment Dockerfile(s)

Similar to the `dev.Dockerfile`, the deployment Dockerfile is used to build the app's Docker image,
but without the development & testing. Using [multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/)
to decrease the final image is recommended.

## Required services

* Make sure codeship is up and running
* Make sure Foresight Sibyl is up and running
