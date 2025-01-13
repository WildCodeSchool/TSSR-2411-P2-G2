# TSSR-2411-P2-G2
# Groupe 2 : The scripting project

<img src="https://ams-training.com/wp-content/uploads/2017/11/powershell.png" alt="logo powershell" width="300"> <img src="https://blog.desdelinux.net/wp-content/uploads/2019/01/bash-logo.jpg" alt="logo Bash" width="400">

## Introduction et mise en contexte

L'automatisation via les scripts ne permet pas uniquement une accélération des processus. Elle apporte de véritables avantages stratégiques et opérationnels.
Il s’agit tout d’abord d’un gain de temps précieux, car les tâches répétitives sont à l’origine très chronophages. 
En les automatisant, les entreprise et organisations peuvent libérer des heures, voire même des jours entiers de travail manuel. 
Ainsi, les équipes peuvent se concentrer sur des tâches à plus forte valeur ajouté. C’est aussi un excellent moyen d’éviter les erreurs (humaines ou non) ainsi que les défaillances.

Une fois correctement configurés, les scripts garantissent une exécution uniforme quel que soit la fréquence ou le volume des tâches.
À mesure que les entreprises grandissent et que leurs opérations se complexifient, l’automatisation offre la flexibilité requise pour adapter et étendre les capacités.

## Présentation du projet

A la demande du client, il à été demandé à notre équipe de concevoir un script proposant un menu avec une navigation ergonomique (présentant des sous menu et différents choix) dans lesquel l’utilisateur à la possibilité de choisir différentes informations dont il aurait besoin parmis les idées suivantes :

- Un premier choix entre une cible (un ordinateur ou un utilisateur)
- Un seconde choix entre une ou des action(s) à effectuer sur la cible et de la recherche d’information.

2 version de ce script ont été demandé : une version via PowerShell sur une machine Windows Server 2022 pour exécuter les tâches du script sur une  machine client Windows 10, et une version via Bash sur un serveur debian afin d'executer des taches sur une machine client Ubuntu.
Les machine serveurs et clientes sont sur le même réseau.

A la suite de quoi il nous est demandé de présenter une exécution complète et fonctionnelle de chaque script et également de fournir une liste de livrable détaillé.



<br>

**Membres du groupes** 
|Membres   | Alexandre   | Camille | Thomas | Tom |
| :--------------- |:---------------:|:---------------:|:---------------:|:---------------:|
|          | Scrum Master | Product Owner | Developer| Developer|
<br>
<br>

## Les choix techniques

### Les Systèmes d'exploitations utilisés:

- ** Les Serveur ** :
  - **Debian 12** : afin d'exécuter le script via Bash avec comme client la machine Ubuntu
  - **Windows Server 2022** : afin d'exécuter le script PowerShell avec comme client la machine Windows 10
  
- **Les Machines cibles** :
  - **Windows 10** pour le client Windows
  - **Ubuntu 22.04/24.04 LTS ** pour le client Linux
