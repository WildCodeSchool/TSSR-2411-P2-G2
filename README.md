# TSSR-2411-P2-G2
# Groupe 2 : The scripting project

<img src="https://ams-training.com/wp-content/uploads/2017/11/powershell.png" alt="logo powershell" width="300"> <img src="https://blog.desdelinux.net/wp-content/uploads/2019/01/bash-logo.jpg" alt="logo Bash" width="400">

---
### 📑 Sommaire
- [📜 Introduction](#introduction)
- [📝 Présentation du Projet](#presentation-projet)
- [👥 Membres et rôles du groupe](#membres-et-rôles-du-groupe)
- [⚙️ Choix Techniques](#choix-tech)
- [⚠️ Difficultés rencontrées](#difficultés-rencontrées)
- [💡 Solutions trouvées](#solutions)
- [🚀 Améliorations envisageable](#améliorations)
---
### **📜 Introduction et mise en contexte**
<span id="introduction"></span> 

L'automatisation via les scripts ne permet pas uniquement une accélération des processus. Elle apporte de véritables avantages stratégiques et opérationnels.
Il s’agit tout d’abord d’un gain de temps précieux, car les tâches répétitives sont à l’origine très chronophages. 
En les automatisant, les entreprise et organisations peuvent libérer des heures, voire même des jours entiers de travail manuel. 
Ainsi, les équipes peuvent se concentrer sur des tâches à plus forte valeur ajouté. C’est aussi un excellent moyen d’éviter les erreurs (humaines ou non) ainsi que les défaillances.

Une fois correctement configurés, les scripts garantissent une exécution uniforme quel que soit la fréquence ou le volume des tâches.
À mesure que les entreprises grandissent et que leurs opérations se complexifient, l’automatisation offre la flexibilité requise pour adapter et étendre les capacités.

---
### **📝 Présentation du Projet**
<span id="presentation-projet"></span>
A la demande du client, il à été demandé à notre équipe de concevoir un script proposant un menu avec une navigation ergonomique (présentant des sous menu et différents choix) dans lesquel l’utilisateur à la possibilité de choisir différentes informations dont il aurait besoin parmis les idées suivantes :

- Un premier choix entre une cible (un ordinateur ou un utilisateur)
- Un seconde choix entre une ou des action(s) à effectuer sur la cible et de la recherche d’information.

2 version de ce script ont été demandé : une version via PowerShell sur une machine Windows Server 2022 pour exécuter les tâches du script sur une  machine client Windows 10, et une version via Bash sur un serveur debian afin d'executer des taches sur une machine client Ubuntu.
Les machine serveurs et clientes sont sur le même réseau.
A la suite de quoi il nous est demandé de présenter une exécution complète et fonctionnelle de chaque script et également de fournir une liste de livrable détaillé.

---
### **👥 Membres et rôles du groupe**
<span id="membres-et-rôles-du-groupe"></span>  

| Prénom    | Rôles              | Tâches
| --------- | ------------------ | ------------------ 
| Alexandre | Scrum Master       | Powershell
| Camille   | Product Owner      | Powershell
| Tom       | Developer          | Bash
| Thomas    | Developer          | Bash

---
### **⚙️ Choix Techniques**
<span id="choix-tech"></span> 
### Les Systèmes d'exploitations utilisés:

- **Les Serveur** :
  - **Debian 12** : afin d'exécuter le script via Bash avec comme client la machine Ubuntu
  - **Windows Server 2022** : afin d'exécuter le script PowerShell avec comme client la machine Windows 10
  
- **Les Machines cibles** :
  - **Windows 10** pour le client Windows
  - **Ubuntu 22.04/24.04 LTS ** pour le client Linux

Les machines sont configuré via virtualbox

---
### **⚠️ Difficultés rencontrées**
<span id="difficultés-rencontrées"></span>
Nous avons rencontré plusieurs difficulté au cours de ce projet :

- **La configuration des VM sous virtualbox** : La stabilité sous virtualbox n'était pas optimum notamment concernant nos VM Windows server et Windows 10 ce qui a considerablement ralentit le projet.
- **Difficultés rencontrées au niveau de la connection SSH bash** : via debian, OpenSSH seul ne prend pas en charge l'entrée de mot de passe automatisée via la ligne de commande sans passer par un outil externe tel que SSHPASS
- **Difficultés rencontrées au niveau de la connection SSH powershell** : Difficulté à installer la connectivité SSH du serveur au client via un serveur SSH
- **Difficultés rencontrées au niveau de la connection WINRM** : Difficulté a configurée Winrm pour effectuée des commandes en remote.
- **Difficultés rencontrées au passage d'information d'un script a l'autre** : Difficulté a faire en sorte que le premier script passe bien au second le nom de la machine ou l'ip à laquel l'utilisateur veux se connecter.

### **💡 Solutions trouvées**
<span id="solutions"></span>

- **Configuration de pare-feu** : Adaptation des règles de pare-feu pour permettre une communication fluide entre les machines virtuelles.
- **Configuration connectivité SSH** : Via debian , en réponse au proble rencontré lors des essais de connectivité SSH, installation des logiciels OpenSSH et SSHPASS avant de faire fonctionner le script et également intégrer SSHPASS au script afin de garantir le bon fonctionnement de la connectivités.
- **connection WINRM** : Aucune solution n'a encore été trouvé / implantée a ce jour, nous avons abort cette méthode pour passer sur posh ssh.
- **passage d'information d'un script a l'autre** : Apres beaucoup d'essaie a invoquer le second script en lui transmettant soit le nom de la machine cible, soit l'ip cible. Nous avons trouver un moyen de le lancée en lui transmettant la variable $Target.
  
### **🚀 Améliorations envisageable**
<span id="améliorations"></span>
### **🖥️ Powershell**
- **L'Optimisation du scripts** : Il est toujours possible d'améliorer les deux scripts pour réduire le temps d'exécution et optimiser l'utilisation des ressources.
- **Un meilleur visuel** : Proposer une meilleure expérience utilisateur grâce à une architecture plus travaillé des menus ainsi qu'une amélioration de son esthétique.

### **🐧 Linux**
- **Définir une variable pour la cible** : On a dû modifier dans le script 10 à 11 lignes avec le bon utilisateur, comme on l'avait fait sur une machine de test. Cela nous aurait fait gagner du temps et améliorer l'optimisation du script.
- **Optimisation de la journalisation** : La journalisation n'est pas très optimisée, on a du mal à s'y retrouver. Ça fait l'affaire, mais c'est un point à améliorer pour pouvoir mieux s'y retrouver dans toute cette masse d'informations.
- **Amélioration visuelle** : Quand on utilise la commande pour lister les utilisateurs, on ne les voit pas tous s'afficher.
