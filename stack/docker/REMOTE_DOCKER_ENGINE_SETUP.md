# Setup a remote Docker Engine

This guide assumes that the engine is going to be installed on a Debian Jessie machine, which uses systemd to start the docker daemon. This part of the guide is based on:

 - [Control and configure Docker with systemd](https://docs.docker.com/engine/admin/systemd)
 - [Protect the Docker daemon socket](https://docs.docker.com/engine/security/https)

## Why not just use Docker Machine?

Docker Machine is GREAT for starting up secure remote Docker hosts on AWS, Azure, Digital Ocean and
many others <u>if you'll going to be the only user to use these, from a single computer.</u> If this
is your case - or you want to learn something cool - don't hurt yourself. Be gone and use Docker
Machine instead.

For those of you still here: Docker Machine creates those instances in most cases running the
provisioning via SSH, using an auto-generated RSA private/public key.

## 1: Enabling unsecured access from the outside - a first baby step

We'll need re-configure the engine to start the engine listening to both the local Unix socket
*AND* the unsecure HTTP socket on TCP port 2375.

First, configure the remote server's firewall (or network security group on AWS/Azure) settings, so
the engine is accessible at the **TCP port 2375**.

On the remote machine, create (or edit, if it's already present) the file at
`/etc/systemd/system/docker.service`, which let's you override default Docker daemon settings:

```
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375
```

Notice that:
 - The empty `ExecStart=` line removes any previous configuration.
 - The `-H fd://` option enables listening on the Unix socket
 - The `-H tcp://0.0.0.0:2375` option enables listening on the HTTP socket

Next, we'll need to flush the configuration changes onto systemd, and restart the docker daemon
service:

```
sudo systemctl daemon-reload && sudo systemctl restart docker
```

After this, you may point your local Docker client to the remote engine by setting the `DOCKER_HOST`
environment variable:

```
export DOCKER_HOST=[your-remote-server-address]:2375
```

You're ready to issue commands via `docker` and `docker-compose`\*. Test your connectivity to the
remote engine:

```
docker info
```

## 2: Securing access to the engine

There are some security-wise things you might be wary of at this point:

  * Pushing potentially private code (i.e. Docker Images of your client's apps) and sensitive
  secrets (passwords, etc) into an unknown engine maliciously impersonating your own remote engine.

  * Allow an unauthorized user to run unknown code/processes (i.e. malicious Docker Containers) on
  your remote engine.

These two problems are solved using server and client TLS certificates, and we'll need to create
those, and configure the remote engine to use a secure connection over TCP port 2376, instead of the
previously configured one at port 2375.

(TODO: Write this down...)
