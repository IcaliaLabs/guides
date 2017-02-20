# Docker Swarm

## Why Swarm over Rancher?

Rancher was our preferred cluster administration tool on 2015 & early 2016. Since mid-2016, Swarm
comes now by default with the Docker Engine (since version 1.12). It has scheduling, routing mesh
(by port) and health check etc. It is far easier to setup and with minimal requirements over a more complex setup with Rancher. Besides, we're shedding off the weight of "multiple-vendor complexity"
for this task.

However, if our client really needs deployment to their own infrastructure (servers, networks, etc), *AND* commercial support is required, we MUST recommend Docker Data Center's Universal Control Plane (UCP, for which we're the first Docker partner here in México)

## Enabling a Docker Swarm Cluster

### 1: Enable access to the remote engines over TCP

Although you can launch services and stacks from any of the swarm manager nodes, it is more useful
to connect your host's docker client - where you have all of your compose files & other configs - to
any of the remote swarm managers.

The guide to setup a remote engine & accessing it from your computer was moved here: [Setup a remote Docker Engine](./REMOTE_DOCKER_ENGINE_SETUP.md)

### 2: Creating the swarm and adding more nodes to it
