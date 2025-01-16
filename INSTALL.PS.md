# Présentation des Scripts Powershell 

## Powershell

### Première partie : Doc graph admin 

1. Log

![image](https://github.com/user-attachments/assets/caeb21c4-a37e-4d38-97cd-f9b683691e64)

<br>
Ce début de script va nous servir à créer un dossier log (sous reserve que ce dossier existe déja ).
Le fichier "log" dans ce dossier est une journalisation de la session ouvert et va avoir pour but de stocker toutes les actions qui sont effectué sur la session lorsque l'on lance le script.

<br>
<br>

2. La création de la fenêtre principale

![image](https://github.com/user-attachments/assets/5727c985-d9e8-46d1-973a-4c11a6c22ee8)

<br>
Ce petit bout de script permet de créer la fenêtre principale via Windows form, avec les dimensions suivantes = ($Form.ClientSize = "380,300). 

<br>
<br> 

3. La création des boutons

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

![image](https://github.com/user-attachments/assets/9a087564-befb-41ac-9207-3f8384c5d3cf)

<br>

Ici, nous avons la partie du script qui s'occupe de créer en windows.form deux textbox qui vont servir à entrer la machine cible (soit le nom de la machine, soit sont ip).
Comme pour les boutos en windows.form ci dessus nous pouvons paramétrer leurs emplacement dans la fenêtre ($TextBox2.Location NewObject System.Drawing.Point(30,130 et leurs largeurs ($TextBox2.Width 240).

<br>
<br>

5. Les textes indicatifs

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

![image](https://github.com/user-attachments/assets/2c17adc2-e6ea-4002-86a4-fae5c610916b)

<br>

Pour cette partie,  nous allons créer des labels (toujours via windows form.)
Le rôle de ces labels sera de nous indiquer, apres avoir appuyer sur le bouton "connexion", si la-dite connexion à reussi ou echoué.
Nous pouvons ici aussi modifier son emplacement ($Label2.Location NewObject System.Drawing.Point(30,150, et sa taille ($Label2.Size NewObject System.Drawing.Size(320,20.

<br>
<br>

7 .La fonction pour effectuer un ping

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

![image](https://github.com/user-attachments/assets/b60fe23b-b796-4660-8215-5f62a7722e05)



Nous aurons ici la fin du script en deux ligne qui comporte respectivement, une ligne pour l'affichage de la fenêtre en windows form($Form.ShowDialog()).
Et la deuxieme ligne pour renvoyer l'arret du script dans le terminal (Write-Log "Arrêt du script.)

<br>
<br>

Voila qui conclu ce premier script.


### Deuxième partie : le script Camille.ps1

1. Cible, SSH et log


![image](https://github.com/user-attachments/assets/008c2283-9d1f-4bc3-b384-00d5155965f5)

<br>

Ce début de Script montre comment importer le module SSH pour la connectivité entre la machine serveur et la machine cible.
Le paramètre ($Target) représentant une cible, comme une adresse IP ou un nom de machine lors de l'exécution du script.
Egalement, on initialise deux variables globales : $Cible (contenant la cible) et $Utilisateur (fixée à "wilder").
"Add-Type -AssemblyName System.Windows.Forms" Charge la bibliothèque permettant de créer des interfaces graphiques avec Windows Forms.
Enfin, Le module de script "chemin du fichier log" permet de définir un chemin pour enregistrer les logs, vérifie si le dossier Logs existe (sinon elle le crée) et active la capture des commandes exécutées et des résultats dans un fichier de log.

2. La création de la fenêtre principale

![image](https://github.com/user-attachments/assets/d8809a6e-0eb2-4e9a-8722-13e1b85bc2f0)
<br>

Cette partie du script permet de créer notre fenêtre principale grâce à Windows Forms.
On configure alors un titre, la taille de notre fenêtre, et la position initiale centrée à l'écran.

3. Les résultats des boutons

![image](https://github.com/user-attachments/assets/e7a4a044-44e3-411e-912c-2a4e8986c530)
<br>

Ce bout de script ajoute une boîte de texte (en lecture seule) à la fenêtre, permettant d'afficher les résultats des commandes de nos futurs boutons.
Encore une fois, via Windows forms, vous pouvez configurer la taille et largeurs de votre encadré.

4. Le mot de passe

![image](https://github.com/user-attachments/assets/59c3ec62-695d-48bd-a99a-a475f001200d)
<br>

Ce petit bout de scrip va demander à l'utilisateur de saisir un mot de passe pour se connecter à la machine cible via SSH. Ce mot de passe est stocké de manière sécurisée.

5. La création de la credential

![image](https://github.com/user-attachments/assets/8bfe0542-7ff9-4fda-9ba0-d6784aad1320)

Cette autre petit bout de script permet la création d'une crédential : celle-ci tilise le mot de passe et le nom de la cible pour créer un objet PSCredential.
et Tente d'établir une session SSH avec la machine cible.

6 . Création de la textbox

![image](https://github.com/user-attachments/assets/deae57f0-93f9-48e9-ab91-b951e2160015)

Ici, nous allons créer une textbox. Cela correspond à une zone de texte permettant de saisir des informations (comme le nom d'un utilisateur par exemple) pour des opérations.
Encore une foi, celle ci étant crée via Windows forms, elle est totalement personnalisable à votre guise : $TextBox3.Location = New-Object System.Drawing.Point(10,370).

7. La fonction pour sauvegarder les résultats dans le fichier "info"

![image](https://github.com/user-attachments/assets/3f4fd0d3-6ae7-46eb-97df-e2b0f387ae2b)

<br>

Cette fonction sauvegarde les résultats affichés dans un fichier texte.
Celui ci est nommé dynamiquement selon la date et le nom de l'ordinateur.
Dans ce fichier seront envoyé le résultats des sous boutons d'informations que nous verrons par la suite dans ce script

8. La création de boutons: les boutons principaux

![image](https://github.com/user-attachments/assets/5d600a89-a231-48ac-b070-7db4df20c221)
<br>

Nous rentrons dans le vif du sujet avec la création des boutons principaux !
Ici, toujours via Windows form, on crée deux bouton nommé "Cible" et "Utilisateur".
Les boutons permettent d'accéder à leurs sous boutons respectif pour pouvoir aller chercher les informations nécessaire.
Ces boutons sont bien sûr personnalisable comme les boutons précédents.

9. La création des 6 sous-boutons pour le bouton principal "Cible"

![image](https://github.com/user-attachments/assets/dae55e6e-7e62-4506-800e-550f70200227)
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

![image](https://github.com/user-attachments/assets/84d11c7c-391b-45ca-a514-ffa621c63e47)
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

![image](https://github.com/user-attachments/assets/8e18f4af-3a9b-47c7-b9bf-5d1636909546)
<br>

Pour ce bout de bout de script , nous allons aborder l'event Handler :
Chaque bouton est associé à une action spécifique via des blocs Add_Click.
Cela contrôle la visibilité des éléments dans l'interface graphique ( notre fenêtre principale)  en fonction du bouton cliqué.
Si le bouton Cible est sélectionné, les outils liés à la machine cible deviennent accessibles, et ceux liés à l'utilisateur sont masqués.
Si le bouton Utilisateur est sélectionné, l'inverse se produit.
L'objectif est de rendre l'interface plus intuitive et de ne montrer que les options pertinentes en fonction du contexte choisi (machine cible ou utilisateur).

12. L'event Handler des sous boutons du bouton principal "Cible"

![image](https://github.com/user-attachments/assets/b1c4d79c-747d-47da-9e2e-3e572b58c9a5)
<br>

Ici, nous allons créer les event handler concernant les sous boutons du bouton principal " cible"
Chaque sous-bouton déclenche une commande spécifique exécutée sur une machine distante via une session SSH.
voici une petit explication de cette commande importante :
- Invoke-SSHCommand :Permet d'exécuter des commandes sur notre machine ciblle via SSH.(Le paramètre -SessionId $Cosh.SessionId identifie la session SSH active.)
Save-Result : permet desauvegarder les résultats dans un fichier ou une base de données enZones de texte ($txtResult.Text) :
Les informations sont affichées à l'utilisateur via une interface graphique et peuvent être sauvegardées pour consultation ultérieure ( dans le fichier info ou log pâr exemple)

13. L'event Handler des sous boutons du bouton principal "Utilisateur"

![image](https://github.com/user-attachments/assets/5b3baa7b-7962-4331-88cd-d90aedf27fbf)
<br>

Ce bout de script reprend le même princique qu'au dessus mais cette fois ci pour les sous boutons de notre boutons principal "utilisateur" :
il permet de récupérer des informations détaillées sur les utilisateurs locaux de notre machine cible (nom, dernière connexion, liste des comptes).
ces fonctionnalitées permettent d'exécuter toutes ces commandes à distance via une session SSH (Invoke-SSHCommand).

14. Fin du script

![image](https://github.com/user-attachments/assets/e4906203-a363-4cbf-8a1a-ac61402dfbbf)

Ce bout de script cloture le script ainsi que de la fonctionnalité windows.form
Il met également fin à la retranscription des informations recherché dans le script en partance pour notre fichier de journaling (le fichier log)
<br>
<br>

Vous trouverez ici le script complet :

#----------------------------------------------------------------
                 #récuperation du nom machine/ip

param ( 
    [string]$Cible
)

Write-Host "machine cible : $Cible ."

#----------------------------------------------------------------

Add-Type -AssemblyName System.Windows.Forms

#----------------------------------------------------------------
                    #import du module SSH

Import-Module Posh-SSH

#----------------------------------------------------------------
                # Chemin du fichier de log

$LogFilePath = "C:\Users\vboxuser\Desktop\p2main\Logs\journal_script2.log"
if (!(Test-Path "C:\Users\vboxuser\Desktop\p2main\Logs")) {
    New-Item -ItemType Directory -Path "C:\Users\vboxuser\Desktop\p2main\Logs" | Out-Null
}
Start-Transcript -Path $LogFilePath -Append

#----------------------------------------------------------------
            # Creation de la fenetre principale

$form = New-Object System.Windows.Forms.Form
$form.Text = "Informations Cible ou Utilisateur"
$form.Size = New-Object System.Drawing.Size(400, 470)
$form.StartPosition = "CenterScreen"

#----------------------------------------------------------------
      # Encadrer pour afficher les résultats des boutons

$txtResult = New-Object System.Windows.Forms.TextBox
$txtResult.Multiline = $true
$txtResult.ReadOnly = $true
$txtResult.ScrollBars = "Vertical"
$txtResult.Size = New-Object System.Drawing.Size(360, 80)
$txtResult.Location = New-Object System.Drawing.Point(10, 270)
$form.Controls.Add($txtResult)

#----------------------------------------------------------------
                 # demander le mots de passe

$mdp = Read-Host -AsSecureString "`nVeuillez renseignée le mot de passe de la cible : $Cible."

#----------------------------------------------------------------
                    # Crée un PSCredential

$Credential = New-Object System.Management.Automation.PSCredential($Cible, $mdp)

#----------------------------------------------------------------
                    # crée un séssion ssh

$Cossh = New-SSHSession -ComputerName $Cible -Credential $Credential -ConnectionTimeout 5 -ErrorAction SilentlyContinue


#----------------------------------------------------------------
                    # Création de TextBox

# TextBox pour entrée du nom machine
$TextBox3 = New-Object System.Windows.Forms.TextBox
$TextBox3.Location = New-Object System.Drawing.Point(10,370)
$TextBox3.Width = 360
$Form.Controls.Add($TextBox3)

#----------------------------------------------------------------
# Fonction pour sauvegarder les résultats dans un fichier texte

function Save-Result {
    param (
        [string]$Content
    )

    $date = (Get-Date).ToString("yyyyMMdd")
    $desktopPath = "C:\Users\vboxuser\Desktop\p2main"
    $fileName = "info_${env:COMPUTERNAME}_${date}.txt"
    $filePath = Join-Path -Path $desktopPath -ChildPath $fileName

    $Content | Out-File -FilePath $filePath -Encoding UTF8 -Append
    "Résultat enregistrée dans $filePath" | Out-String
}

#----------------------------------------------------------------
                     #création de bouton

        # Les Boutons principaux (Cible et Utilisateur)

#----------------

#bouton principal cible
$btnCible = New-Object System.Windows.Forms.Button
$btnCible.Text = "Cible"
$btnCible.Size = New-Object System.Drawing.Size(100, 30)
$btnCible.Location = New-Object System.Drawing.Point(70, 20)
$form.Controls.Add($btnCible)

#----------------

#bouton principal utilisateur
$btnUtilisateur = New-Object System.Windows.Forms.Button
$btnUtilisateur.Text = "Utilisateur"
$btnUtilisateur.Size = New-Object System.Drawing.Size(100, 30)
$btnUtilisateur.Location = New-Object System.Drawing.Point(200, 20)
$form.Controls.Add($btnUtilisateur)

#----------------
             # Les 6 Sous-boutons pour "Cible"
#----------------

#bouton version de l'os
$btnOSVersion = New-Object System.Windows.Forms.Button
$btnOSVersion.Text = "DerniÃ¨re version de l'OS"
$btnOSVersion.Size = New-Object System.Drawing.Size(160, 25)
$btnOSVersion.Location = New-Object System.Drawing.Point(10, 50)
$btnOSVersion.Visible = $false
$form.Controls.Add($btnOSVersion)

#----------------

#bouton nom de la machine
$btnComputerName = New-Object System.Windows.Forms.Button
$btnComputerName.Text = "Nom de l'ordinateur"
$btnComputerName.Size = New-Object System.Drawing.Size(160, 25)
$btnComputerName.Location = New-Object System.Drawing.Point(10, 80)
$btnComputerName.Visible = $false
$form.Controls.Add($btnComputerName)

#----------------

#bouton adresse ip
$btnIPAddress = New-Object System.Windows.Forms.Button
$btnIPAddress.Text = "Adresse IP actuelle"
$btnIPAddress.Size = New-Object System.Drawing.Size(160, 25)
$btnIPAddress.Location = New-Object System.Drawing.Point(10, 110)
$btnIPAddress.Visible = $false
$form.Controls.Add($btnIPAddress)

#----------------

#bouton info cible
$btnInfoBatchCible = New-Object System.Windows.Forms.Button
$btnInfoBatchCible.Text = "Lot d'informations"
$btnInfoBatchCible.Size = New-Object System.Drawing.Size(160, 25)
$btnInfoBatchCible.Location = New-Object System.Drawing.Point(10, 140)
$btnInfoBatchCible.Visible = $false
$form.Controls.Add($btnInfoBatchCible)

#----------------

#bouton arret pc
$Boutonstop = New-Object System.Windows.Forms.Button
$Boutonstop.Text = "Arret"
$Boutonstop.Size = New-Object System.Drawing.Size(160, 25)
$Boutonstop.Location = New-Object System.Drawing.Point(10, 170)
$Boutonstop.Visible = $false
$form.Controls.Add($Boutonstop)

#----------------

#bouton reboot pc
$Boutonreboot  = New-Object System.Windows.Forms.Button
$Boutonreboot.Text = "Redémarrage"
$Boutonreboot.Size = New-Object System.Drawing.Size(160, 25)
$Boutonreboot.Location = New-Object System.Drawing.Point(10, 200)
$Boutonreboot.Visible = $false
$form.Controls.Add($Boutonreboot)

#----------------
              # Les 6 Sous-boutons pour "Utilisateur"
#----------------

#bouton nom de l'utilisateur
$btnUserName = New-Object System.Windows.Forms.Button
$btnUserName.Text = "Nom de l'utilisateur"
$btnUserName.Size = New-Object System.Drawing.Size(160, 25)
$btnUserName.Location = New-Object System.Drawing.Point(200, 50)
$btnUserName.Visible = $false
$form.Controls.Add($btnUserName)

#----------------

#bouton derrniere date de connexion
$btnLastLogin = New-Object System.Windows.Forms.Button
$btnLastLogin.Text = "Derniere date de connexion"
$btnLastLogin.Size = New-Object System.Drawing.Size(160, 25)
$btnLastLogin.Location = New-Object System.Drawing.Point(200, 80)
$btnLastLogin.Visible = $false
$form.Controls.Add($btnLastLogin)

#----------------

#bouton liste des utilisateurs
$btnUserList = New-Object System.Windows.Forms.Button
$btnUserList.Text = "Liste des utilisateurs"
$btnUserList.Size = New-Object System.Drawing.Size(160, 25)
$btnUserList.Location = New-Object System.Drawing.Point(200, 110)
$btnUserList.Visible = $false
$form.Controls.Add($btnUserList)

#----------------

#bouton lots d'information
$btnInfoBatchUtilisateur = New-Object System.Windows.Forms.Button
$btnInfoBatchUtilisateur.Text = "Lot d'informations"
$btnInfoBatchUtilisateur.Size = New-Object System.Drawing.Size(160, 25)
$btnInfoBatchUtilisateur.Location = New-Object System.Drawing.Point(200, 140)
$btnInfoBatchUtilisateur.Visible = $false
$form.Controls.Add($btnInfoBatchUtilisateur)

#----------------

#bouton ajout d'un utilisateur
$Boutoncu = New-Object System.Windows.Forms.Button
$Boutoncu.Text = "Création utilisateur"
$Boutoncu.Size = New-Object System.Drawing.Size(160, 25)
$Boutoncu.Location = New-Object System.Drawing.Point(200, 170)
$Boutoncu.Visible = $false
$form.Controls.Add($Boutoncu)

#----------------

#bouton suprimer un utilisateur
$Boutondu = New-Object System.Windows.Forms.Button
$Boutondu.Text = "Suppression utilisateur"
$Boutondu.Size = New-Object System.Drawing.Size(160, 25)
$Boutondu.Location = New-Object System.Drawing.Point(200, 200)
$Boutondu.Visible = $false
$form.Controls.Add($Boutondu)


#----------------------------------------------------------------
                         #Event handler

# Actions des 2 boutons principaux
$btnCible.Add_Click({
    $currentTarget = $env:COMPUTERNAME

    $btnOSVersion.Visible = $true
    $btnComputerName.Visible = $true
    $btnIPAddress.Visible = $true
    $btnInfoBatchCible.Visible = $true
    $Boutonstop.Visible = $true
    $Boutonreboot.Visible = $true


    $btnUserName.Visible = $false
    $btnLastLogin.Visible = $false
    $btnUserList.Visible = $false
    $btnInfoBatchUtilisateur.Visible = $false
    $Boutoncu.Visible = $false
    $Boutondu.Visible = $false
})

$btnUtilisateur.Add_Click({
    $currentTarget = $env:USERNAME

    $btnOSVersion.Visible = $false
    $btnComputerName.Visible = $false
    $btnIPAddress.Visible = $false
    $btnInfoBatchCible.Visible = $false
    $Boutonstop.Visible = $false
    $Boutonreboot.Visible = $false

    $btnUserName.Visible = $true
    $btnLastLogin.Visible = $true
    $btnUserList.Visible = $true
    $btnInfoBatchUtilisateur.Visible = $true
    $Boutoncu.Visible = $true
    $Boutondu.Visible = $true
})

#----------------------------------------------------------------
                #Event handler des sous-boutons Cible

#Event handler version os
$btnOSVersion.Add_Click({
    $result = Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "(Get-CimInstance Win32_OperatingSystem).Version"
    $txtResult.Text = "DerniÃ¨re version de l'OS : $result"
    Save-Result -Content $txtResult.Text
})

#------------------------------

#Event handler nom machine
$btnComputerName.Add_Click({
    $result = Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "$env:COMPUTERNAME"
    $txtResult.Text = "Nom de l'ordinateur : $result"
    Save-Result -Content $txtResult.Text
})

#------------------------------

#Event handler adresse ip
$btnIPAddress.Add_Click({
    $result = Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notlike "Loopback*" }).IPAddress"
    $txtResult.Text = "Adresse IP actuelle : $result"
    Save-Result -Content $txtResult.Text
})

#------------------------------

#Event handler information machine
$btnInfoBatchCible.Add_Click({
    $osVersion = Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "(Get-CimInstance Win32_OperatingSystem).Version"
    $computerName = $env:COMPUTERNAME
    $ipAddress = Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notlike "Loopback*" }).IPAddress"

    $content = "Dernière version de l'OS : $osVersion`nNom de l'ordinateur : $computerName`nAdresse IP actuelle : $ipAddress"
    Save-Result -Content $content
})

#------------------------------

#Event handler pour arret machine
$Boutonstop.Add_Click({ 
    Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "Stop-Computer"
})

#------------------------------

#Event handler pour arret machine
$Boutonreboot.Add_Click({ 
    Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "Restart-Computer"
})

#----------------------------------------------------------------
            # Actions des sous-boutons Utilisateur

#Event handler nom utilisateur
$btnUserName.Add_Click({
    $result = Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "$env:USERNAME"
    $txtResult.Text = "Nom de l'utilisateur : $result"
    Save-Result -Content $txtResult.Text
})

#------------------------------

#Event handler derniere connexion
$btnLastLogin.Add_Click({
    $result = Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "(Get-EventLog -LogName Security -Newest 1 -InstanceId 4624).TimeGenerated"
    $txtResult.Text = "DerniÃ¨re connexion : $result"
    Save-Result -Content $txtResult.Text
})

#------------------------------

#Event handler liste utilisateur
$btnUserList.Add_Click({
    $result = Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "net user | Out-String"
    $txtResult.Text = "Liste des utilisateurs locaux : `n$result"
    Save-Result -Content $txtResult.Text
})

#------------------------------

#Event handler information utilisateur
$btnInfoBatchUtilisateur.Add_Click({
    $userName = $env:USERNAME
    $lastLogin = Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "(Get-EventLog -LogName Security -Newest 1 -InstanceId 4624).TimeGenerated"
    $userList = Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "net user | Out-String"

    $content = "Nom de l'utilisateur : $userName`nDernière connexion : $lastLogin`nListe des utilisateurs locaux :`n$userList"
    Save-Result -Content $content
})

#------------------------------

#Event handler pour création utilisateur
$Boutoncu.Add_Click({ 
    $nomnewuser = $TextBox3.text
    Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "New-LocalUser -Name $nomnewuser -NoPassword"
})

#------------------------------

#Event handler pour suppression utilisateur
$Boutondu.Add_Click({ 
    $nomdeluser = $TextBox3.text
    Invoke-SSHCommand -SessionId $Cossh.SessionId -Command "Remove-LocalUser -Name $nomdeluser"
})

#----------------------------------------------------------------
                    # Affichage de la fenetre

[void]$form.ShowDialog()

#----------------------------------------------------------------
# stop la transcription dans les logs pour ce script

Stop-Transcript







































