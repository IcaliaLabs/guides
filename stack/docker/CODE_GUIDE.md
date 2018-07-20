# Dockerized Project Guide by IcaliaLabs

A guide

## Table of Contents

1. [Dockerfiles](#dco)
2. [Docker Compose files](#example2)
3. [bin/entrypoint-dev](#dco)

## Dockerfiles

All projects in IcaliaLabs must contain at least a Docker setup

### General

While it's not a must, using an alpine version of an official image is highly preferred for both development and deployable images.

When deploying to Heroku using a Heroku stack, the preferred base must be the traditional methods (i.e. not using the Heroku Container Registry)

### Development Dockerfiles

All projects must have a development Dockerfile called `dev.Dockerfile` in which all of the development and runtime dependencies must be installed.

Depending on your development platform's dependency manager it should include the installation of libraries

Some dependency managers for which dependency installation is in the Dockerfile **is encouraged**:

* Rubygems (Ruby)
* Maven (Java)
* Gradle (Java)

Some dependency managers for which dependency installation in the Dockerfile **is discouraged**:

* Composer (PHP)
* NPM & Yarn (nodejs)

### Deployable Image Dockerfiles

A project may have one or several Dockerfiles which should build a production-deployable Docker image.

Use `Dockerfile` as the filename if the same image may be used for all of the processes of the app (i.e. Rails, Sidekiq & Hutch)

Use `[processname].Dockerfile` if different images must be used for each of the processes. This is particularly necessary if deploying to Heroku using the Heroku Container Registry.

### Development & Deployable Dockerfiles

When possible, try to use the most layers between both Development & Deployable Dockerfiles
