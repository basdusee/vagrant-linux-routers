# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/debian-9.0"

  config.vm.synced_folder "salt/roots/", "/srv/salt/"
  config.vm.provision :salt do |salt|
    salt.masterless = true
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
    salt.colorize = true
    salt.verbose = true
    salt.log_level = "warning"
    salt.pillar({
      "keepaliveip" => {
        "www" => "192.168.23.101",
        "firewall" => "192.168.23.10"
      },
      "webserver" => {
          "firewall" => {
            "tcp" => [22, 80],
            "udp" => [68]
          }
      },
      "router" => {
          "firewall" => {
            "tcp" => [22],
            "udp" => [68]
          },
          "forward" => {
            "tcp" => [22, 80, 443],
            "udp" => [68]
          }
      }
    })
  end

#######################################################################################

  config.vm.define "Edge1" do |edge1|
    edge1.vm.hostname = "edge1"

    edge1.vm.network "private_network", ip: "192.168.23.5/24", nic_type: "virtio"
    edge1.vm.network "private_network", ip: "172.23.0.250/24", virtualbox__intnet: "internal-affairs", nic_type: "virtio"
    edge1.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
        vb.name = "edge1"
    end
  end

#######################################################################################

  config.vm.define "Edge2" do |edge2|
    edge2.vm.hostname = "edge2"

    edge2.vm.network "private_network", ip: "192.168.23.6/24", nic_type: "virtio"
    edge2.vm.network "private_network", ip: "172.23.0.251/24", virtualbox__intnet: "internal-affairs", nic_type: "virtio"
    edge2.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
        vb.name = "edge2"
    end
  end

#######################################################################################

  config.vm.define "Introuter" do |introuter|
    introuter.vm.hostname = "introuter"

    introuter.vm.network "private_network", ip: "192.168.123.254/24", virtualbox__intnet: "deepspace", nic_type: "virtio"
    introuter.vm.network "private_network", ip: "172.23.0.10/24", virtualbox__intnet: "internal-affairs", nic_type: "virtio" 
    introuter.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
        vb.name = "introuter"
    end

    introuter.vm.provision :shell, :inline => "sudo systemctl disable salt-minion && sudo systemctl stop salt-minion"
  end

#######################################################################################

  config.vm.define "Darkrouter" do |darkrouter|
    darkrouter.vm.hostname = "darkrouter"

    darkrouter.vm.network "private_network", ip: "192.168.123.10/24", virtualbox__intnet: "deepspace", nic_type: "virtio"
    darkrouter.vm.network "private_network", ip: "192.168.101.254/24", virtualbox__intnet: "darknet", nic_type: "virtio" 
    darkrouter.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
        vb.name = "darkrouter"
    end
    darkrouter.vm.provision :shell, :inline => "sudo systemctl disable salt-minion && sudo systemctl stop salt-minion"
  end

#######################################################################################

  config.vm.define "Darkweb01" do |darkweb01|
    darkweb01.vm.hostname = "darkweb01"

    darkweb01.vm.network "private_network", ip: "192.168.101.10/24", virtualbox__intnet: "darknet", nic_type: "virtio" 
    darkweb01.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
        vb.name = "darkweb01"
    end
  end

#######################################################################################

  config.vm.define "Darkweb02" do |darkweb02|
    darkweb02.vm.hostname = "darkweb02"

    darkweb02.vm.network "private_network", ip: "192.168.101.11/24", virtualbox__intnet: "darknet", nic_type: "virtio" 
    darkweb02.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
        vb.name = "darkweb02"
    end
  end
  
#######################################################################################
 
end
