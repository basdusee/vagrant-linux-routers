# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "Router1" do |router1|
    router1.vm.box = "bento/debian-9.0"
    router1.vm.hostname = "router1"

    router1.vm.network "private_network", ip: "192.168.23.5", nic_type: "virtio"
    router1.vm.network "private_network", ip: "172.23.0.5/24", virtualbox__intnet: "internal-affairs", nic_type: "virtio"
    router1.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
        vb.name = "router1"
    end

    router1.vm.synced_folder "salt/roots/", "/srv/salt/"
    router1.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
      salt.colorize = true
    end
  end

  config.vm.define "Router2" do |router2|
    router2.vm.box = "bento/debian-9.0"
    router2.vm.hostname = "router2"

    router2.vm.network "private_network", ip: "192.168.23.6", nic_type: "virtio"
    router2.vm.network "private_network", ip: "172.23.0.6/24", virtualbox__intnet: "internal-affairs", nic_type: "virtio"
    router2.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
        vb.name = "router2"
    end

    router2.vm.synced_folder "salt/roots/", "/srv/salt/"
    router2.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
      salt.colorize = true
    end
  end


  config.vm.define "Introuter" do |introuter|
    introuter.vm.box = "bento/debian-9.0"
    introuter.vm.hostname = "introuter"

    introuter.vm.network "private_network", ip: "192.168.123.254", virtualbox__intnet: "darkweb", nic_type: "virtio"
    introuter.vm.network "private_network", ip: "172.23.0.10/24", virtualbox__intnet: "internal-affairs", nic_type: "virtio" 
    introuter.vm.provider "virtualbox" do |vb|
        vb.memory = "382"
        vb.name = "introuter"
    end

    introuter.vm.synced_folder "salt/roots/", "/srv/salt/"
    introuter.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
      salt.colorize = true
    end
  end
end
