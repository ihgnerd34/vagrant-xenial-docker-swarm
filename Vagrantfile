# -*- mode: ruby -*-
# vi: set ft=ruby :

# set nodecount to the total number of nodes you want, must be an odd number
nodecount = 3

# VirtualBox settings
# Increase vmmemorysize if you want more than 512mb memory in the vm's
vmmemorysize = 512
# Increase vmcpucount if you want more cpu's per vm
vmcpucount = 1

instances = []
# the first node, docker1, will be the swarm manager
manager_ip = "192.168.10.2"
(1..nodecount).each do |n| 
  nodename = "docker#{n}"
  nodeip = "192.168.10.#{n+1}"
  instances.push({:name => nodename, :ip => nodeip})
end

File.open("./hosts", 'w') { |file| 
  instances.each do |i|
    file.write("#{i[:ip]} #{i[:name]}.vagrant #{i[:name]}\n")
  end
}

Vagrant.require_version ">= 1.8.4"
Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = vmmemorysize
    v.cpus = vmcpucount
  end
  instances.each do |instance| 
    config.vm.define instance[:name] do |i|
      i.vm.box = "ubuntu/xenial64"
      i.vm.hostname = instance[:name]
      i.vm.network "private_network", ip: "#{instance[:ip]}"
      i.vm.provision "shell", inline: "sudo apt-get install -y software-properties-common apt-transport-https"
      i.vm.provision "shell", inline: "curl -sSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
      i.vm.provision "shell", inline: "sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable'"
      i.vm.provision "shell", inline: "sudo apt-get update"
      i.vm.provision "shell", inline: "sudo apt-get install -y docker-ce --allow-unauthenticated"
      i.vm.provision "shell", inline: "sudo usermod -aG docker vagrant"
      if File.file?("./hosts") 
        i.vm.provision "file", source: "hosts", destination: "/tmp/hosts"
        i.vm.provision "shell", inline: "cat /tmp/hosts >> /etc/hosts", privileged: true
      end 
      if instance[:ip] == manager_ip
        i.vm.provision "shell", inline: "docker swarm init --advertise-addr #{instance[:ip]}"
        i.vm.provision "shell", inline: "docker swarm join-token -q worker > /vagrant/token"
      else
        i.vm.provision "shell", inline: "docker swarm join --advertise-addr #{instance[:ip]} --listen-addr #{instance[:ip]}:2377 --token `cat /vagrant/token` #{manager_ip}:2377"
      end
    end
  end
end
