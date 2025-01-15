# Installation et configuration du serveur Debian

## Prérequis

(Pour cette démonstration, VMware Workstation a été utilisé. Toutefois, la procédure est également compatible avec d'autres hyperviseurs.)

- VMware Workstation
- Une ISO Debian 12





-Configurer un réseau interne dans VMware
Pour permettre aux machines de communiquer entre elles sur un réseau isolé, nous allons utiliser un réseau interne Host-Only.
-Ouvrir VMware Workstation ou VMware Player

    Lancez VMware Workstation

-Configurer le réseau interne (Host-Only)

    Allez dans Edit > Virtual Network Editor.
    Dans l'éditeur de réseau, assurez-vous que le réseau VMnet1 est configuré comme Host-Only.
    Vous pouvez personnaliser l'adresse du réseau ou garder l'adresse par défaut 172.16.10.0/24.
    Cliquez sur OK pour enregistrer les paramètres.

## Créer et configurer la machine virtuelle serveur (SRVLX01 - Debian)

-Créer la machine virtuelle serveur sous VMware

    Ouvrir VMware et créer une nouvelle machine virtuelle :
        Sélectionnez File > New Virtual Machine.
        Choisissez Custom (advanced).
        Sélectionnez Installer un système d'exploitation ultérieurement.
        Choisissez Linux et la version Debian.
        Nommez la machine virtuelle SRVLX01.
        Allouez 2 Go de RAM et 1 CPU (ou plus, selon vos besoins).
        Créez un disque dur virtuel (20 Go suffisent).
        Cliquez sur Finish pour terminer la configuration.

-Configurer l'interface réseau

    Sélectionnez SRVLX01 dans VMware.
    Allez dans Edit virtual machine settings > Network Adapter.
    Choisissez Host-Only et assurez-vous que la machine est connectée à VMnet1.
    Cliquez sur OK pour enregistrer les modifications.

-Installer Debian sur le serveur

    Démarrez la machine virtuelle et installez Debian depuis l'ISO.
    Suivez les étapes d'installation décrites dans les captures suivantes jusqu'à ce que Debian soit opérationnel.
        Lors de l'installation, définissez le mot de passe Azerty1* pour l'utilisateur administrateur (root).
![1](https://github.com/user-attachments/assets/656c3c61-3410-4645-beec-8f1cd404ca75)
![2](https://github.com/user-attachments/assets/0d3bc6bf-b1bf-4d89-97b0-f8d21bd1faea)
![3](https://github.com/user-attachments/assets/b5ca4aee-b512-42eb-b34a-573954bd8a44)
![5](https://github.com/user-attachments/assets/cf6a3aa0-b2bd-4eee-8528-5efc1ad2e817)
![6](https://github.com/user-attachments/assets/53a9026f-ca4e-4b92-af7a-6d4fed41a59b)
![8](https://github.com/user-attachments/assets/2b753618-a16e-48bc-831b-9eae50ccbe8b)
![9](https://github.com/user-attachments/assets/dfebfd9f-4030-42b1-8ad0-cc927eaed1b9)
![10](https://github.com/user-attachments/assets/71d58fd1-269d-4bee-bda0-80c883a7ed68)
![11](https://github.com/user-attachments/assets/f654d47d-bb87-4494-9224-0275569b426b)
![12](https://github.com/user-attachments/assets/8df5beac-2d9d-489d-83ba-1b1b9aa9c06f)
![13](https://github.com/user-attachments/assets/25ddbecc-20bf-4482-adbf-f5c9cbf6ca0d)
![14](https://github.com/user-attachments/assets/aa0954f5-5530-4f73-a4a1-6c01b191d9b6)
![15](https://github.com/user-attachments/assets/aae5e4bb-daa9-450f-99e9-288b04f4d85f)
![16](https://github.com/user-attachments/assets/d719e887-f66f-4bf6-8748-216aea978dea)
![17](https://github.com/user-attachments/assets/52aec668-e1ae-4195-b61a-81fb5bd31b15)
![18](https://github.com/user-attachments/assets/92c51ec0-4695-432f-971c-fad31d16e58d)
![19](https://github.com/user-attachments/assets/e4198b1f-85d3-48be-8c3b-55833f4a82ac)


 -Faire les mises à jour de la distribution


![21](https://github.com/user-attachments/assets/6ed47f0a-6983-4bb2-ad4c-00be5d8429de)
![22](https://github.com/user-attachments/assets/384ed90d-2764-4555-a1ec-ee629e67c6d5)


-Configurer une adresse IP statique sur le serveur Debian

    Une fois l'installation terminée et le système Debian démarré, ouvrez un terminal.
    Modifiez en respectant bien les indentations le fichier de configuration Netplan pour définir une adresse IP statique :
![Capture d’écran 2025-01-15 121151](https://github.com/user-attachments/assets/73a634a4-a6ef-4288-80ee-7ceb7dcaaa5f)
sudo nano /etc/netplan/00-installer-config.yaml

-Mettez à jour le fichier avec les paramètres suivants :


![26](https://github.com/user-attachments/assets/2ad1aeb5-2090-468f-bbc9-ba12f0653617)


-Appliquez la nouvelle configuration réseau :

sudo netplan apply

-Vérifiez que l'adresse IP est correcte :

    ip a

-Installer et configurer SSH sur le serveur Debian

    Installez le serveur SSH :

sudo apt update
sudo apt install openssh-server

-Vérifiez que le service SSH est actif :

sudo systemctl status ssh

-Si nécessaire, démarrez-le :

sudo systemctl start ssh

-Assurez-vous que le serveur SSH démarre au boot :

    sudo systemctl enable ssh

## Créer et configurer la machine virtuelle cliente (CLILIN01)

-Créer la machine virtuelle cliente sous VMware

    Ouvrir VMware et créer une nouvelle machine virtuelle pour la machine cliente.
    Choisissez Custom (advanced).
    Sélectionnez Installer un système d'exploitation ultérieurement et choisissez Linux ou une autre distribution compatible.
    Nommez la machine CLILIN01.
    Allouez 2 Go de RAM et 1 CPU (ou plus, selon vos besoins).
    Créez un disque dur virtuel (20 Go suffisent).
    Cliquez sur Finish pour terminer la configuration.

-Configurer l'interface réseau de la machine cliente

    Sélectionnez CLILIN01 dans VMware.
    Allez dans Edit virtual machine settings > Network Adapter.
    Choisissez Host-Only et assurez-vous que la machine est connectée à VMnet1.
    Cliquez sur OK pour enregistrer les modifications.

-Installer le système d'exploitation sur la machine cliente

    Démarrez la machine virtuelle cliente et installez le système d'exploitation.
    Lors de l'installation, définissez le mot de passe Azerty1* pour l'utilisateur.

-Configurer une adresse IP statique sur la machine cliente

    Une fois l'installation terminée et le système démarré, ouvrez un terminal.
    Éditez le fichier Netplan pour configurer l'IP statique :

sudo nano /etc/netplan/00-installer-config.yaml

-Mettez à jour le fichier avec les paramètres suivants :

network:
  version: 2
  renderer: networkd
  ethernets:
    ens33:  # Remplacez "ens33" par le nom réel de votre interface réseau
      dhcp4: false
      addresses:
        - 172.16.10.30/24
      gateway4: 172.16.10.1  # L'adresse IP de la passerelle, si nécessaire
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4

-Appliquez la nouvelle configuration :

sudo netplan apply

-Vérifiez que l'adresse IP est correcte :

    ip a

-Vérifier la communication SSH entre les machines
-Tester la connectivité entre les machines

    Depuis la machine cliente (CLILIN01), testez la connectivité en pingant l'adresse IP du serveur (SRVLX01) :

ping 172.16.10.10

-Tester la connexion SSH depuis CLILIN01 vers SRVLX01 :

    ssh root@172.16.10.10

        Le mot de passe à entrer sera Azerty1*.
        Vous devriez être connecté au serveur Debian via SSH.

-Vérification du SSH sur le serveur

    Depuis la machine serveur (SRVLX01), testez la connexion SSH depuis CLILIN01 :

ssh root@172.16.10.30

    Le mot de passe sera également Azerty1*
