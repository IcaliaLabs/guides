# All Things Docker

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

## Installing Docker and enabling a development workstation

Installing Docker used to be a daunting task. Not anymore. Install "Docker Toolbox"
and watch it sing. You can check the details

## Docker on Production

### Cloud Providers
If your'e going to run your Docker app in production, the recommended option is
to use a Docker-capable provider:

- Microsoft Azure: These guys are betting on Docker so much they've managed to
  make Docker run natively on Windows! (on a side note, we're now partners with them!)

### Existing private infrastructure

While setting up a private, on-premises Docker host / cloud is not recommendable,
most often than not the client will insist so much on running the app in their
existing infrastructure *

Being that the case, the best alternative we've evaluated is creating a Docker
host farm using Rancher to manage all the available Docker hosts:

 - If the client is open to use a different linux distro, we highly recommend
 enabling new Docker host machines using RancherOS linux distro.

 - If not, make sure you:
  - Work side-by-side with the client's best network/sysadmin person. The
  client's linux distro of choice may be completely alien to you. Plus, he's
  better acquainted with the client's network rules and peculiarities.
  - Ask this person on how to install the required version of Docker for Rancher
  to work.
























-------------
* Most of the time it is because they've invested so
much money on their own infrastructure, they are not willing to use/pay another
provider, even if the provider is cheaper and more reliable!
