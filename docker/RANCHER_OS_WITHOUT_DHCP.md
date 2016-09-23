# Installing Rancher OS on machines in a network without DHCP

This is actually just a quick note I made after a mishap I had when installing
[RancherOS](http://rancher.com/rancher-os/) on virtual infrastructure for a
government agency.

Basically, the servers that where enabled for us where in a network without DHCP
(the server that assigns IP's automatically to new machines). When this is the
case, there's no access to the Internet until you assign yourself an unused IP.

Usually, that requires making some network configuration, and then restarting the
machine... which in the case of the RancherOS install - being a "LiveCD" kind of
installer - will not persist the configuration upon reboot, ending right where
we started.

I was failing to realize that as <strong>EVERY OTHER OS SERVICE in RancherOS</strong>,
the `network` service is also a container running on 'system-docker', and is managed
by the command `ros`.

Here are the steps I took while installing RancherOS in this situation:

## 1: Configure the network settings using `ros config set`

You'll need the following:
* The name of the network interface you want to use - usually `eth0`.
* The desired IP address you want for that network interface.
* The network's gateway IP from which the machine will access the internet.
* The network's DNS servers, in case there are, as RancherOS will defaults to
google's DNS servers.

```bash
# 1: Set the desired IP - Notice the 'CIDR' format for the submask:
sudo ros config set rancher.network.interfaces.eth0.address 10.23.0.100/24

# 2: Set the gateway:
sudo ros config set rancher.network.interfaces.eth0.gateway 10.23.0.1

# 3: Set the maximum transmission unit on the interface:
sudo ros config set rancher.network.interfaces.eth0.mtu 1500

# 4: Specify that the network interface's network has no DCHP:
sudo ros config set rancher.network.interfaces.eth0.dhcp false

# 5: Set the DNS servers - Notice the array notation:
sudo ros config set rancher.network.dns.nameservers [10.23.0.10,10.23.0.11]
```

Notice that the keys we're setting are actually the keys used in the
`cloud-config.yml` file, so we're basically editing - via `ros config` - the
contents of the config file currently used.

## 2: Restarting the network service using `ros service`:

Now that Rancher OS has a useable network configuration, the next step is to
make the network service restart with the changed network configuration:

```bash
sudo ros service restart network
```

### Bug in RancherOS 0.4.3
At the time of this article, the RancherOS current version was 0.4.3. This
particular version has a bug that is currently being figured out - see issues [#669](https://github.com/rancher/os/pull/669) and
[#720](https://github.com/rancher/os/issues/720) - that prevents the DNS
configuration set with `ros config` from being written into the `/etc/resolv.conf`
file. In that case, you should manually edit `/etc/resolv.conf` to look like this:

```
nameserver 10.23.0.10
nameserver 10.23.0.11
```

# 3: Check if the network is accesible:
Ping some servers by their domains, to check if the DNS configuration is working,
and the docker servers are accessible:

```
ping docker.io
ping hub.docker.com
```

# 4: Proceed with the install

After the network service is properly configured and running again, you should be
able to:

* Download a `cloud-config.yml` file <strong>from a trusted location</strong> -
this is actually necessary, as typing those length `ssh-key` lines is impossible!
* Run the RancherOS install routine, which should download images successfully from
the Docker Hub.

```bash
# Let's assume that we downloaded a cloud-config.yml file on /tmp, and will
# install the OS to /dev/sda:
sudo ros install -c /tmp/cloud-config.yml -d /dev/sda
```

Watch it go. Remember, once the machine restarts you won't be able to SSH into
the server without the SSH key specified on the `cloud-config.yml` file!!!!!
