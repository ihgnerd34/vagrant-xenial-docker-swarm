# Ubuntu Xenial Docker Swarm Vagrant

This is a simple Vagrantfile which can be used to spin few Virtualbox nodes with Docker-ce installed
and Docker Swarm initialized. The VMs are all Ubuntu 16.04 LTS amd64. 

# Customize

By default `vagrant up` spins up 3 machines: `docker1`, `docker2`, and `docker3`. You can adjust how many
nodes you want by editing the `Vagrantfile`, and setting the `nodecount` variable. The NAT network used
is 192.168.10.x. The first node, docker1, is the manager. The rest are workers.

```ruby
nodecount = 3
```

You can modify the size of the VMs by changing these variables:

```ruby
vmmemorysize = 512
```

```ruby
vmcpucount = 1
```

`/etc/hosts` on every machine is populated with an IP address and a
name of every other machine, so that names are resolved within the
cluster.

# License 

Apache

# Author 

Patrick Wolfe @whistl034

