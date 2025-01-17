## SOMMAIRE

- [📜 1-Script 1 Doc Graph](#docgraph)
- [⚙️ log](#log)
- [⚙️ La création de la fenêtre principale](#fenetre)
- [⚙️ La création des boutons](#bouton)
- [⚙️ La création des textbox](#textbox)
- [⚙️ Les textes indicatifs](#texte)
- [⚙️ Les labels pour afficher les résultats](#label)
- [⚙️ La fonction pour effectuer un ping](#ping)
- [⚙️ L'Event handler pour la connexion nom machine](#machine)
- [⚙️ Event handler pour la connexion ](#ip)
- [⚙️ Fin du script](#script)

- [📜 2 -Script 2 : Camille.ps1](#ps1)
- [⚙️ Cible, SSH et log](#ssh)
- [⚙️ La création de la fenêtre principale](#principale)
- [⚙️ Les résultats des boutons](#resultats)
- [⚙️ Le mot de passe](#mdp)
- [⚙️ La création de la credential](#mdp)
- [⚙️ Création d'une session SSH](#session)
- [⚙️ Création de la textbox](#texte)
- [⚙️ La fonction pour sauvegarder les résultats dans le fichier "info"](#info)
- [⚙️ La création de boutons: les boutons principaux](#principaux)
- [⚙️ La création des 6 sous-boutons pour le bouton principal "Cible"](#ciblet)
- [⚙️ La création des 6 sous-boutons pour le bouton principal "Utilisateur"](#utilisateur)
- [⚙️ L'event Handler](#handler)
- [⚙️ L'event Handler des sous boutons du bouton principal "Cible"](#handler2)
- [⚙️ L'event Handler des sous boutons du bouton principal "Utilisateur""](#handler3)
- [⚙️ fin du script"](#fin)

# Présentation des Scripts Powershell 

## Powershell

### Première partie : Doc graph admin 
<span id="docgraph"></span>

1. Log
<span id="log"></span>
<br>

![image](https://github.com/user-attachments/assets/caeb21c4-a37e-4d38-97cd-f9b683691e64)

<br>
Ce début de script va nous servir à créer un dossier log (sous reserve que ce dossier existe déja ).
Le fichier "log" dans ce dossier est une journalisation de la session ouvert et va avoir pour but de stocker toutes les actions qui sont effectué sur la session lorsque l'on lance le script.

<br>
<br>

2. La création de la fenêtre principale
 <span id="fenetre"></span>

![image](https://github.com/user-attachments/assets/5727c985-d9e8-46d1-973a-4c11a6c22ee8)

<br>
Ce petit bout de script permet de créer la fenêtre principale via Windows form, avec les dimensions suivantes = ($Form.ClientSize = "380,300). 

<br>
<br> 

3. La création des boutons
<span id="bouton"></span>

![image](https://github.com/user-attachments/assets/68e1182f-8d9d-4593-82f4-9eafcfa918ee)

<br>
Cette partie du script vas permettre de créer des boutons avec windows.form. Ces boutons servent à se connecter une fois la machine cible donnée.
Les commandes de celle ci sont dans un event handler un peux plus bas dans le script.
A noter qu'ici nous sommes uniquement sur la partie graphique qui sert à créer les boutons, les placer et parametrer aussi leur taille (largeur
($Bouton2.Width 80), longueur($Bouton2.Height 40)).
Nous pouvons également modifier leurs contenus, mais ici, il resteront “connexion ($Bouton2.Text = "Connexion"")

<br>
<br>

4. La création des Textbox
<span id="textbox"></span>

![image](https://github.com/user-attachments/assets/9a087564-befb-41ac-9207-3f8384c5d3cf)

<br>

Ici, nous avons la partie du script qui s'occupe de créer en windows.form deux textbox qui vont servir à entrer la machine cible (soit le nom de la machine, soit sont ip).
Comme pour les boutos en windows.form ci dessus nous pouvons paramétrer leurs emplacement dans la fenêtre ($TextBox2.Location NewObject System.Drawing.Point(30,130 et leurs largeurs ($TextBox2.Width 240).

<br>
<br>

5. Les textes indicatifs
<span id="texte"></span>

![image](https://github.com/user-attachments/assets/6561e3b2-c347-4b3b-be7a-1baeddbca551)

<br>

Sur cette partie nous allons nous intéresser aux textes indicatif qui servent à aiguiller l'utilisateur.
Sur les deux textbox ci dessus elle sont aussi en windows.form de type label.
Le premier sert à renseigner que le premier text box est à utiliser pour une connexion via le nom de la machine cible.
Quand au deuxième, il est utilisé pour renseigner que second text box est à utiliser pour une connexion via l' adresse ip de la machine cible.
encore une fois nous pouvons modifier leurs placement ( $Label.Location ) et leurs taille $Label.Size ).

<br>
<br>

6 .Les labels pour afficher les résultats
<span id="label"></span>

![image](https://github.com/user-attachments/assets/2c17adc2-e6ea-4002-86a4-fae5c610916b)

<br>

Pour cette partie,  nous allons créer des labels (toujours via windows form.)
Le rôle de ces labels sera de nous indiquer, apres avoir appuyer sur le bouton "connexion", si la-dite connexion à reussi ou echoué.
Nous pouvons ici aussi modifier son emplacement ($Label2.Location NewObject System.Drawing.Point(30,150, et sa taille ($Label2.Size NewObject System.Drawing.Size(320,20.

<br>
<br>

7 .La fonction pour effectuer un ping
<span id="ping"></span>

![image](https://github.com/user-attachments/assets/1f22ab53-517f-4287-bab7-f1fc28432377)

<br>
Juste en dessous, nous avons la fonction "testping" qui sera utilisé pour tester la connectivité entre la machine hôte et la machine cible en faisant le test d'un
ping unique (Test-Connection ComputerName $Target Count 1 ErrorActionStop | Out-Null).
De plus, & $Menu2 -Target $Target permet de passer la main au Script Camille.PS1. UN message d'erreur apparaitra si le script camille.ps1 n'as pas été trouvé

<br>
<br>


Si la machine hote arrive à bien ping la machine cible, nous auront un retour du windows form label (un peu ci dessus nous disant que le ping a réussi.)
Dans cette fonction nous avons aussi la condition qui spécifie que si le ping réussi, il lance le second script ou se trouve les options client(& $Menu2 $Target).
Si le second script na pas été trouvé, il renverra donc un message qui explique que le second script n'a pas été trouvée :(Write-Host "Le script $Menu2 n'a pas été trouvé." # Message de débogage).
Si le ping échoue, le second script ne sera pas lancé et le label windows form nous indiquera sous les text box que le ping a échoué ( Write-Host "Échec de la connexion à $Target" # Message de débogage)
PS : les message de débogage ont été mis en place pour que certaines commandes du script fonctionne, car sans, nous rencontrions de gros problèmes.
(Notament des commandes qui n'étaient pas totalement prise en compte voir pas du tout.)
Nous enverrons également au deuxième script le nom machine ou l'adresse ip fourni pas l'utilisateur.
Nous nous en servirons donc en tant que condition de lancement du deuxième script (& $Menu2 $Target) que nous avons au préalable indiqué en tant que variable dans les event handler ci dessous.

<br>
<br>

8 .L'Event handler pour la connexion nom machine
<span id="machine"></span>

![image](https://github.com/user-attachments/assets/d080ff7a-aeb9-4ae9-ab96-e1dd9c91af34)

<br>
Pour les deux dernière partie de ce premier script, nous allons créer les deux event handler des bouton de connexions avec leurs actions associer.(doc graph admin 6)
Donc, nous allons commencer par le premier event handler qui s'occupe du bouton de connexion via le nom machine.
Nous allons gérer ici le label d"affichage de résultat pour savoir si la connexion à la machine a réussi ou échoué
($Label.Text = "Connexion à $NomMachineréussie).qui sera ecrit en vert ($Label.ForeColor =System.Drawing.Color]::Green)
si néammoins la connexion echoue, elle va renvoyer un message au label disant que la connexion échoué ($Label.Text = "Connexion à $NomMachine échoué).
Ce message sera par ailleur affiché en rouge ($Label.ForeColor =System.Drawing.Color]::Red)

Nous avons aussi essayer d'implémenter une commande pour fermer la fenêtre du premier script lorsque que le second est lancée après un ping réussi.
Cependant, nous n'avons jusque la pas réussi à la faire fonctionner correctement..
"($Form.Close() # Ferme la fenêtre du premier script")"

<br>
<br>

9 . Event handler pour la connexion IP
<span id="ip"></span>

![image](https://github.com/user-attachments/assets/117d809d-43e3-4889-a020-b3f0ca59f542)

<br>

dans ce dernier bout de script nous allons créer le second event handeler.
celui ci agis exactement comme le premier, à la seul difference que celui-ci est programme une connexion via l'adresse ip de la machine cible.
Nous gérons donc ici le label d'affichage de résultat, savoir si la connexion à la machine a réussi ou échoué :
($Label.Text = "$Label2.Text = "Connexion à$AdresseIp réussie).qui sera ecrit en vert ($Label.ForeColor =System.Drawing.Color]::Green)
Si la connexion échoue, cela va renvoyer un message au label disant que la connexion échouée ($Label2.Text = "Connexion à $AdresseIp échouée).
Ce message sera par ailleurs affiché en rouge ($Label.ForeColor = System.Drawing.Color]::Red).
Comme pour le premier event handler,nous avons essayer d'implémenter une commande pour fermer la fenêtre du premier script lorsque que le second est lancée après un ping réussi.
Cependant, nous n'avons jusque la pas réussi à la faire fonctionner correctement."($Form.Close() # Ferme la fenêtre du premier script)"

<br>
<br>

10. Fin du script
<span id="script"></span>

![image](https://github.com/user-attachments/assets/b60fe23b-b796-4660-8215-5f62a7722e05)



Nous aurons ici la fin du script en deux ligne qui comporte respectivement, une ligne pour l'affichage de la fenêtre en windows form($Form.ShowDialog()).
Et la deuxieme ligne pour renvoyer l'arret du script dans le terminal (Write-Log "Arrêt du script.)

<br>
<br>

Voila qui conclu ce premier script.


### Deuxième partie : le script Camille.ps1
<span id="ps1"></span>

1. Cible, SSH et log
<span id="ssh"></span>


![image](https://github.com/user-attachments/assets/008c2283-9d1f-4bc3-b384-00d5155965f5)

<br>

Ce début de Script montre comment importer le module SSH pour la connectivité entre la machine serveur et la machine cible.
Le paramètre ($Target) représentant une cible, comme une adresse IP ou un nom de machine lors de l'exécution du script.
Egalement, on initialise deux variables globales : $Cible (contenant la cible) et $Utilisateur (fixée à "wilder").
"Add-Type -AssemblyName System.Windows.Forms" Charge la bibliothèque permettant de créer des interfaces graphiques avec Windows Forms.
Enfin, Le module de script "chemin du fichier log" permet de définir un chemin pour enregistrer les logs, vérifie si le dossier Logs existe (sinon elle le crée) et active la capture des commandes exécutées et des résultats dans un fichier de log.

2. La création de la fenêtre principale
<span id="principale"></span>

![image](https://github.com/user-attachments/assets/fb9dcc40-c138-4411-8174-632af1ea3c13)

<br>

Cette partie du script permet de créer notre fenêtre principale grâce à Windows Forms.
On configure alors un titre, la taille de notre fenêtre, et la position initiale centrée à l'écran.

3. Les résultats des boutons
<span id="resultats"></span>

![image](https://github.com/user-attachments/assets/0a66973b-67dd-49dd-af6a-6ba6a9781add)

<br>

Ce bout de script ajoute une boîte de texte (en lecture seule) à la fenêtre, permettant d'afficher les résultats des commandes de nos futurs boutons.
Encore une fois, via Windows forms, vous pouvez configurer la taille et largeurs de votre encadré.

4. Le mot de passe
<span id="mdp"></span>

![image](https://github.com/user-attachments/assets/6c7078dc-8843-461e-83a2-7e73f73d92a3)

<br>

Ce petit bout de scrip va demander à l'utilisateur de saisir un mot de passe pour se connecter à la machine cible via SSH. Ce mot de passe est stocké de manière sécurisée.

5. La création de la credential
<span id="credential"></span>

![image](https://github.com/user-attachments/assets/cc41a77a-d11f-4610-b8a3-49da06477fb2)

<br>
Cette autre petit bout de script permet la création d'une crédential : Le commentaire mentionne que vous devez remplacer la variable ou valeur associée à username par un nom d'utilisateur réel ($global:Utilisateur est utilisé pour stocker cette information.)
La crédential sert à établir une session SSH avec la machine cible.

6. Création d'une session SSH
<span id="session"></span>

![image](https://github.com/user-attachments/assets/484ca46d-377e-44ec-9f6f-4b1969abc423)
<br>

Ce bout de script permet d"établir une connexion SSH à une machine cible et gère les erreurs de connexion :
il Utilise New-SSHSession avec un nom d'hôte ($global:Cible) et des informations d'identification ($Credential).
Pour l'Affichage des détails de la tentative : il Montre le nom d'utilisateur et le mot de passe pour le débogage.
Si la session SSH est établie, le script affiche un message de succès avec l'ID de session.
Sinon, il affiche une erreur et arrête l'exécution.
En cas d'échec, un message d'erreur est affiché et le script s'arrête avec un code de sortie

7 . Création de la textbox
<span id="textboxe"></span>

![image](https://github.com/user-attachments/assets/8efb1f05-247d-4a54-8528-2fbb8b64395b)


Ici, nous allons créer une textbox. Cela correspond à une zone de texte permettant de saisir des informations (comme le nom d'un utilisateur par exemple) pour des opérations.
Encore une foi, celle ci étant crée via Windows forms, elle est totalement personnalisable à votre guise : $TextBox3.Location = New-Object System.Drawing.Point(10,370).

7. La fonction pour sauvegarder les résultats dans le fichier "info"
<span id="info"></span>

![image](https://github.com/user-attachments/assets/160ce72e-32b2-4b40-b1e9-4baf9b6f9903)


<br>

Cette fonction sauvegarde les résultats affichés dans un fichier texte.
Celui ci est nommé dynamiquement selon la date et le nom de l'ordinateur.
Dans ce fichier seront envoyé le résultats des sous boutons d'informations que nous verrons par la suite dans ce script

8. La création de boutons: les boutons principaux
<span id="principaux"></span>

![image](https://github.com/user-attachments/assets/d03aef52-56cb-4476-a72d-144210c0c27a)

<br>

Nous rentrons dans le vif du sujet avec la création des boutons principaux !
Ici, toujours via Windows form, on crée deux bouton nommé "Cible" et "Utilisateur".
Les boutons permettent d'accéder à leurs sous boutons respectif pour pouvoir aller chercher les informations nécessaire.
Ces boutons sont bien sûr personnalisable comme les boutons précédents.

9. La création des 6 sous-boutons pour le bouton principal "Cible"
<span id="ciblet"></span>

![image](https://github.com/user-attachments/assets/ca715494-7df3-4781-85e7-d34445b5e072)

<br>

Nous allons dans un premier temps nous pencher sur les sous boutons du bouton principal "Cible"
En effet, pour aller récuperer les informations dont nous aurons besoin pour le fameux fichier info (créer plus tôt), cette partie du Script permets de créer 6 sous boutons d'information.
Nous avons créer pour ce script les sous boutons :
- " Dernière version de L'OS" nous donnant l'information du système d'explotation utilisé sur la cible
- " Nom de l'ordinateur" permettant comme son nom l'indique de connaitre le nom de l'ordinateur cible
- " Adresse IP actuelle " permettant de donner l'information de l'adresse IP de la cible
- "lot d'information" permettantr en un clic de regrouper les 3 informations dess boutons du dessus
- " Arret" qui permet la mise hors tension de la cible
- " Redémarrage" permettant le redémarrage de la cible

Ces boutons sont également personnalisables

10. La création des 6 sous-boutons pour le bouton principal "Utilisateur"
<span id="utilisateur"></span>

![image](https://github.com/user-attachments/assets/f5ef1e48-d4f8-4c8b-bdff-fa522d462ba8)

<br>

Nous allons maintenant nous pencher sur les sous boutons du bouton principal "Utilisateurs"
Comme ci dessus, pour  récuperer les informations dont nous aurons besoin pour notre fichier info, cette partie du Script permets de créer 6 sous boutons d'information.
Nous avons créer pour ce script les sous boutons :
- " Nom de l'utilisateur" nous donnant l'information du nom utilisateur de la cible
- " dernière date de connexion" permettant  de connaitre la date de la dernière connection de l'utilisateur de la machine cible
- "Liste des utilisateurs" permettant de donner la liste des utilisateurs de la cible
- "lot d'information" permettantr en un clic de regrouper les 3 informations dess boutons du dessus
- "Création d'un utilisateur" permet de créer un nouvel utilisateur
- "Suppression Utilisateur" permet de supprimer un utilisateur

Ces boutons sont également personnalisables comme au dessus grâce à Windows.forms !

11. L'event Handler
<span id="handler"></span>

![image](https://github.com/user-attachments/assets/941f42e7-6bd7-4d2d-911f-27d2e503bb16)

<br>

Pour ce bout de bout de script , nous allons aborder l'event Handler :
Chaque bouton est associé à une action spécifique via des blocs Add_Click.
Cela contrôle la visibilité des éléments dans l'interface graphique ( notre fenêtre principale)  en fonction du bouton cliqué.
Si le bouton Cible est sélectionné, les outils liés à la machine cible deviennent accessibles, et ceux liés à l'utilisateur sont masqués.
Si le bouton Utilisateur est sélectionné, l'inverse se produit.
L'objectif est de rendre l'interface plus intuitive et de ne montrer que les options pertinentes en fonction du contexte choisi (machine cible ou utilisateur).

12. L'event Handler des sous boutons du bouton principal "Cible"
<span id="handler2"></span>

![image](https://github.com/user-attachments/assets/9c56f2c6-3ffa-4a61-aeb8-53e270a39df4)

<br>

Ici, nous allons créer les event handler concernant les sous boutons du bouton principal " cible"
ce bout de script gère des événements liés à des actions SSH sur notre machine cible :
- La Récupération des informations via SSH :
Version de l'OS : Exécute une commande wmic pour obtenir la version de l'OS et l'affiche.
Nom de la machine : Exécute la commande hostname pour récupérer le nom de l'ordinateur.
Adresse IP : Exécute une commande ipconfig pour récupérer l'adresse IP (IPv4).
- La Récupération complète :
Cela Combine les informations (version OS, nom machine, IP) en une seule action pour une vue globale.
Arrêt distant de la machine : Utilise la commande shutdown /s /t 0 pour éteindre la machine via SSH.
Gestion des erreurs :Affiche des messages d’erreur spécifiques si une commande échoue.

Il est concu pour interagir avec une session SSH active et afficher les résultats ou les erreurs dans une interface utilisateur.

13. L'event Handler des sous boutons du bouton principal "Utilisateur"
<span id="handler3"></span>

![image](https://github.com/user-attachments/assets/654b3a69-2704-463e-a2f9-58bb9c757d39)
![image](https://github.com/user-attachments/assets/760e3f13-7b08-49b5-877d-04c790ffd276)

<br>

Ce bout de script reprend le même princique qu'au dessus mais cette fois ci pour les sous boutons de notre boutons principal "utilisateur" :
il permet de récupérer des informations détaillées sur les utilisateurs locaux de notre machine cible (nom, dernière connexion, liste des comptes).
Ce script semble être une interface de gestion d'utilisateur via des événements déclenchés par des boutons. Voici un résumé rapide des fonctionnalités :
- Récupération d'informations utilisateur :
Nom de l'utilisateur : Récupère le nom d'utilisateur courant à partir de la session via une commande PowerShell ($env:USERNAME).
Dernière connexion : Récupère l'heure et la date de la dernière connexion via un événement du journal Windows (ID 4624).
Liste des utilisateurs locaux : Récupère la liste des utilisateurs locaux sur le système en exécutant la commande PowerShell net user.
- Affichage de l'information globale : Un bouton permet de récupérer et d'afficher en une seule fois ,l e nom d'utilisateur, la dernière connexion, la liste des utilisateurs locaux.
Les résultats sont concaténés et affichés dans une zone de texte.
- Création d'un utilisateur :
Permet de créer un utilisateur local avec un nom donné via une commande PowerShell (New-LocalUser).
Le nom est récupéré depuis une zone de texte.
- Suppression d'un utilisateur : supprime un utilisateur local spécifique en exécutant une commande PowerShell (Remove-LocalUser).
Le nom de l'utilisateur à supprimer est fourni via une zone de texte.
- Gestion des erreurs : Chaque commande vérifie si la session est correctement initialisée avant d'exécuter les opérations.
En cas d'erreur (par exemple, session non valide ou échec de la commande), un message d'erreur descriptif est affiché dans une zone de texte.


14. Fin du script
<span id="fin"></span>

![image](https://github.com/user-attachments/assets/b8b9d894-e23a-4d04-8ce1-78a5406a91ad)
<br>

Ce bout de script cloture le script ainsi que de la fonctionnalité windows.form
Il met également fin à la retranscription des informations recherché dans le script en partance pour notre fichier de journaling (le fichier log)
<br>
<br>
