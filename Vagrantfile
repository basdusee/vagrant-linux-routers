# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "Edge1" do |edge1|
    edge1.vm.box = "bento/debian-9.0"
    edge1.vm.hostname = "edge1"

    edge1.vm.network "private_network", ip: "192.168.23.5/24", nic_type: "virtio"
    edge1.vm.network "private_network", ip: "172.23.0.250/24", virtualbox__intnet: "internal-affairs", nic_type: "virtio"
    edge1.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
        vb.name = "edge1"
    end

    edge1.vm.synced_folder "salt/roots/", "/srv/salt/"
    edge1.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
      salt.colorize = true
    end
  end

  config.vm.define "Edge2" do |edge2|
    edge2.vm.box = "bento/debian-9.0"
    edge2.vm.hostname = "edge2"

    edge2.vm.network "private_network", ip: "192.168.23.6/24", nic_type: "virtio"
    edge2.vm.network "private_network", ip: "172.23.0.251/24", virtualbox__intnet: "internal-affairs", nic_type: "virtio"
    edge2.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
        vb.name = "edge2"
    end

    edge2.vm.synced_folder "salt/roots/", "/srv/salt/"
    edge2.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
      salt.colorize = true
    end
  end

  config.vm.define "Introuter" do |introuter|
    introuter.vm.box = "bento/debian-9.0"
    introuter.vm.hostname = "introuter"

    introuter.vm.network "private_network", ip: "192.168.123.254/24", virtualbox__intnet: "darkweb", nic_type: "virtio"
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

  config.vm.define "Darkweb" do |darkweb|
    darkweb.vm.box = "bento/debian-9.0"
    darkweb.vm.hostname = "darkweb"

    darkweb.vm.network "private_network", ip: "192.168.123.10/24", virtualbox__intnet: "darkweb", nic_type: "virtio"
    darkweb.vm.network "private_network", ip: "192.168.101.254/24", virtualbox__intnet: "deepspace", nic_type: "virtio" 
    darkweb.vm.provider "virtualbox" do |vb|
        vb.memory = "382"
        vb.name = "darkweb"
    end

    darkweb.vm.synced_folder "salt/roots/", "/srv/salt/"
    darkweb.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
      salt.colorize = true
    end
  end
end
