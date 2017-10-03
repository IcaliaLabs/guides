# Docker

We currently develop everything using Docker as the engine to encapsulate every app. This has helped us a lot in order to reduce the setup and configuration pain we as developers suffer.

## How tos

There is a bunch of wiki articles on how to setup applications with Docker, head [there](https://github.com/IcaliaLabs/guides/wiki/How-tos) for more explanation on that.

## Why Docker?

  - **Normalized environments**: Eliminates differences between all
  of the developers machines. It also helps to minimize differences between
  development and productive environments, so no more "Yeah it works on your
  machine, but it blows up on mine/production!"
  - **Reduced environment setup time**: The time wasted on installing specific
  services directly on the host is unnecessary with Docker.
  - **Online development servers become unnecessary**: As firing a local server
  app instance is pretty easy with Docker - *if your app is well designed* -
  the need for paying an always-online, in the cloud app instance or servers
  is greatly reduced, saving costs.

### Installing Docker

Installing Docker used to be a daunting task. Not anymore. You can download it from [here](https://www.docker.com/products/docker) and start working right away.

## Docker on Production

Docker enables us to easily migrate all the application infraestructure in just a few minutes from one provider to another and test with more ease.

### Cloud Providers

If you're going to run your Docker app in production, the recommended Docker-capable providers are:

- [Microsoft Azure](https://azure.microsoft.com/en-us/)
- [Digital Ocean](https://www.digitalocean.com/)
- [AWS](https://aws.amazon.com/)

### Existing private infrastructure

While setting up a private, on-premises Docker host / cloud is not recommendable,
most often than not the client will insist so much on running the app on their
existing infrastructure *

That being the case, the best alternative we've evaluated is creating a Docker
host cluster using [Swarm](https://docs.docker.com/swarm/) to manage all the available Docker hosts:

 - If the client is open to use a different linux distro, we highly recommend
 enabling new Docker host machines using a light linux distr, such as [debian](https://www.debian.org/).

 - If not, make sure you:
  - Work side-by-side with the client's best network/sysadmin person. The
  client's linux distro of choice may be completely alien to you. Plus, he's
  better acquainted with the client's network rules and peculiarities.
  - Ask this person on how to install the required version of Docker for the selected distro.

-------------

* Most of the time it is because they've invested so
much money on their own infrastructure, they are not willing to use/pay another
provider, even if the provider is cheaper and more reliable!

## .dockerignore samples

* [Linux](dockerignore_linux)