# css_tp_securite

Les fichiers pour la mise en place du TP Sécurité pratique

## Les pré-requis

### Les ressources informatiques

Pour faire fonctionner ce Labs il faut prévoir au moins 2 CPU /coeurs et 4Go de Ram (8Go est plus judicieux). L'espace disque est de l'ordre des 16 Go.
La virtualisation doit être activée sur le PC hôte (machine physique ) https://support.bluestacks.com/hc/fr-fr/articles/115003174386-Comment-puis-je-activer-la-virtualisation-VT-sur-mon-PC-

### Les applications obligatoires

* Oracle Virtualbox version 6.1 (<https://www.virtualbox.org/wiki/Downloads>)
* Oracle VM VirtualBox Extension Pack (<https://download.virtualbox.org/virtualbox/6.1.18/Oracle_VM_VirtualBox_Extension_Pack-6.1.18.vbox-extpack>)
* HashiCorp Vagrant (<https://www.vagrantup.com/>)

### Les fichiers obligatoires

* choisir le zip en haut à gauche
* cloner avec git : git clone https://github.com/chavinje/css_tp_securite.git

Vous trouverez les reperoires/fichiers :

* ./Vagrantfile : qui contient l'ensemble des déclarations pour la construction du Labs
* scripts/install_sys.sh : exécuté lors de la création de toute les VMs. En théorie il n'y a rien a modifier.
* scripts/install_fw.sh : un script vide puisque c'est à vous de le créer
* scripts/install_attack.sh : pas grand chose de fait. 
* scripts/install_web.sh : install le serveur web en installant et configurant la solution DVWA (https://github.com/digininja/DVWA)

## Description du Labs

Le labs est constitué de 4 machines virtuelles Virtualbox.
Une machine servira pour relié le labs à votre réseau réel (firewall)

### le premier ensemble

<b>Hôte</b> <= Bridge => <b>firewall</b> <= réseau privé 56 

=> <b>attack</b>

=> <b>web</b>

=> <b>victime</b>

* firewall : machine virtuelle avec 2 interfaces en plus du NAT pour vagrant
  * eth0 : NAT 
  * eth1 : réseau privé hôte pour l'intéraction entre les machines du réseau Labs (192.168.56.70/24)
  * eth2 : réseau bridge pour l'ilustration du principe de firewall et de reverse proxy
* web : un serveur web simple contenant le site DVWA
  * eth0 : NAT
  * eth1 : réseau privé hôte (192.168.4.71/24)
* attack : Distribution Kali Linux actuelle. Attention pour obtenir l'interface graphique il faut passer par virtualbox
  * eth0 : NAT
  * eth1 : réseau privé hôte (192.168.4.72/24)
* victime : Windows XP La machine à attaquer avec Metasploit. Une fois le vagrant up et il faut modifier la carte réseau de la machine virtuelle. 
  * carte 1 : réseau privé hôte (192.168.4.xx/24)

## Utilisation des commandes vagrant

Télécharger la box modèle
    ```vagrant box add debian/contrib-stretch64```

Activer une VM uniquement (attack par exemple)
    ```vagrant up attack```

Se connecter à une VM (firewall par exemple)
    ```vagrant ssh firewall```

Arréter une VM
    ```vagrant halt victime```

Détruire toutes les VMs (sans demande de confirmation)
    ```vagrant destroy -f```
