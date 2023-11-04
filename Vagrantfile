# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    
  config.ssh.insert_key = false
  
  config.vm.define "k8s-cp" do |cp|
    cp.vm.box = "shekeriev/debian-11"
    cp.vm.hostname = "k8s-cp"
    cp.vm.network "private_network", ip: "192.168.200.100"
    cp.vm.provider :virtualbox do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
    cp.vm.provision "shell", path: "./setup_scripts/basic_setup.sh"
    cp.vm.provision "shell", path: "./setup_scripts/docker.sh"
    cp.vm.provision "shell", path: "./setup_scripts/k8s.sh"
    cp.vm.provision "shell", path: "./setup_scripts/cp_setup.sh"
    cp.vm.provision "shell", path: "./setup_scripts/export_token.sh"

  end

  config.vm.define "k8s-node1" do |node1|
    node1.vm.box="shekeriev/debian-11"
    node1.vm.hostname = "k8s-node1"
    node1.vm.network "private_network", ip: "192.168.200.101"
    node1.vm.provider :virtualbox do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
    node1.vm.provision "shell", path: "./setup_scripts/basic_setup.sh"
    node1.vm.provision "shell", path: "./setup_scripts/docker.sh"
    node1.vm.provision "shell", path: "./setup_scripts/k8s.sh"
    node1.vm.provision "shell", path: "./setup_scripts/join_cluster.sh"
  end

  config.vm.define "k8s-node2" do |node2|
    node2.vm.box="shekeriev/debian-11"
    node2.vm.hostname = "k8s-node2"
    node2.vm.network "private_network", ip: "192.168.200.102"
    node2.vm.provider :virtualbox do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
    node2.vm.provision "shell", path: "./setup_scripts/basic_setup.sh"
    node2.vm.provision "shell", path: "./setup_scripts/docker.sh"
    node2.vm.provision "shell", path: "./setup_scripts/k8s.sh"
    node2.vm.provision "shell", path: "./setup_scripts/join_cluster.sh"
  end

end
