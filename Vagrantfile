# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
# Machines pour le TP Introduction à la sécurité
#  Réseau physique <== bridge ==> firewalL <= reseau privé hôte 	=> web
#  									                                              => attack
#  									                                              => victime
##############################################################################
# Utilisation de contrib-strech64
# la version contrib pour avoir les vbox guest installées (repertoire partagé)
# la version stretch64 (debian9) pour avoir 0,5 Go par machine

  config.vm.define "firewall" do |machine|
    machine.vm.box = "debian/contrib-stretch64"
    machine.vm.box_url = "debian/contrib-stretch64"
    machine.vm.hostname = "firewall"
# Configuration des 2 interfaces 
    machine.vm.network :private_network, ip: "192.168.56.70"
    machine.vm.network "public_network", use_dhcp_assigned_default_route: true
# Un repertoire partagé (Attention il faut les virtualbox Additions installé sur l'hôte)
    machine.vm.synced_folder "./data", "/partage"
    machine.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--name", "firewall"]
      v.customize ["modifyvm", :id, "--groups", "/CSS_securite"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
    machine.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
      sleep 3
      service ssh restart
    SHELL
    machine.vm.provision "shell", path: "scripts/install_sys.sh"
    machine.vm.provision "shell", path: "scripts/install_fw.sh"
  end

# Configuration pour le serveur web victime
# Basé sur DVWA - https://dvwa.co.uk/
  config.vm.define "web" do |machine|
    machine.vm.box = "debian/contrib-stretch64"
    machine.vm.box_url = "debian/contrib-stretch64"
	  machine.vm.hostname = "web"
    machine.vm.network :private_network, ip: "192.168.56.71"
    machine.vm.synced_folder "./data", "/partage"
    machine.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--name", "web"]
      v.customize ["modifyvm", :id, "--groups", "/CSS_securite"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
    machine.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
      sleep 3
      service ssh restart
    SHELL
    machine.vm.provision "shell", path: "scripts/install_sys.sh"
    machine.vm.provision "shell", path: "scripts/install_web.sh"
  end

# Machine attaquante : Kali Linux
# Cette machine peut etre remplacé par une debian avec les paquets pour l'attaque 
  config.vm.define "attack" do |machine|
    machine.vm.box = "kalilinux/rolling"
    machine.vm.box_check_update = false
    machine.vm.hostname = "attack"
    machine.vm.network :private_network, ip: "192.168.56.72"
    machine.vm.provider "virtualbox" do |v|
      v.gui = false
      v.customize ["modifyvm", :id, "--name", "attack"]
      v.customize ["modifyvm", :id, "--groups", "/CSS_securite"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end    
    machine.vm.provision "shell", path: "scripts/install_sys.sh"
    machine.vm.provision "shell", path: "scripts/install_attack.sh"  
  end

# Configuration de la victime Windows XP
# Windows Xp pour des failles connues et une faible consomation de ressources
    config.vm.define "victime" do |machine|
      machine.vm.box = "chavinje/secu-xp"
      machine.vm.box_url = "chavinje/secu-xp"
      machine.vm.provider :virtualbox do |v|
        v.gui = false
        v.customize ["modifyvm", :id, "--name", "victime"]
        v.customize ["modifyvm", :id, "--groups", "/CSS_securite"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
        v.customize ["modifyvm", :id, "--memory", 1024]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end
    end
end
