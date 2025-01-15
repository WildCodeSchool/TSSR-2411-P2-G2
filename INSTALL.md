# Présentation des Scripts Powershell et Bash 

## Powershell

### Première partie : Doc graph admin 

1. Log

![image](https://github.com/user-attachments/assets/ac2696a8-b06b-4584-a937-a3be1605d6af)
<br>
ce début de script va nous servir à créer un dossier log (sous reserve que ce dossier existe déja ).
Le fichier "log" dans ce dossier est une journalisation de la session ouvert et va avoir pour but stocker toutes les action qui sont effectuée sur la session lorsque l'on lance le script.

2. La création de la fenêtre principale

![image](https://github.com/user-attachments/assets/65173065-2bf7-4d8f-88d7-e7fb9de1e174)
<br>
Ce petit bout de script permet de créer la fenêtre principale via Windows form, avec cles
dimensions suivantes = ($Form.ClientSize = "380,300). 

3. La création des boutons

![image](https://github.com/user-attachments/assets/4cea8db2-95a3-4849-8ff8-476670919ac6)
<br>
Cette partie du script vas permettre de créer des bouton avec windows form. Ces boutons servent à se connecter une fois la machine cible donnée.
Les commandes de celle ci sont dans un event handler un peux plus bas dans le script.
A noter qu'ici nous somme uniquement sur la partie graphique qui sert a créer les bouton, les placer et parametrer aussi leur taille (largeur
($Bouton2.Width 80), longueur($Bouton2.Height 40))
nous pouvons également modifier leurs contenus, mais ici, il resterons “connexion ($Bouton2.Text = "Connexion"")

4. La création des Textbox

![image](https://github.com/user-attachments/assets/efdac5b3-a8ff-4aa3-89ac-7df5e837fc65)
<br>

Ici, nous avons la partie du script qui s'occupe de créer en windows form deux text box qui vont servir à entrée la machine cible (soit le nom de la machine, soit sont ip).
Comme pour les bouton en windows form ci dessus nous pouvons paramétrer leurs emplacement dans la fenêtre ($TextBox2.Location NewObject System.Drawing.Point(30,130 et leurs largeurs ($TextBox2.Width
240).

5. Les textes indicatifs

![image](https://github.com/user-attachments/assets/034fc64c-5999-4e1e-beaa-094de6ce03db)
<br>
sur cette partie nous allons nous intéresser aux textes indicatif qui servent a aiguiller l'utilisateur.
Sur les deux text box ci dessus elle sont aussi en windows form de type label.
Le premier sert à renseigner que le premier text box est à utiliser pour une connexion via le nom de la machine cible.
Quand au deuxième, il est utilisé pour renseigner que second text box est a utilisée pour une connexion via l' adresse ip de la machine cible.
encore une fois nous pouvons modifier leurs placement( $Label.Location ) et leurs taille $Label.Size ).

6. Les labels pour afficher les résultats

![image](https://github.com/user-attachments/assets/d6645e8a-87bd-449c-8020-cc55ea5276ea)
<br>

Pour cette partie nous allons créer des labels ( toujours via windows form.)
Le rôle de ces labels sera de nous indiquer apres avoir appuyer sur le bouton "connexion" si la-dite connexion à reussi ou echoué.
Nous pouvons ici aussi modifier son emplacement ($Label2.Location NewObject System.Drawing.Point(30,150, et sa taille ($Label2.Size NewObject System.Drawing.Size(320,20.

6.La fonction pour effectuer un ping

![image](https://github.com/user-attachments/assets/59421bf8-3b98-485b-8da8-51f9a101b39d)
<br>
Juste en dessous, nous avons la fonction "testping" qui sera utilisé pour tester la connectivité entre la machine hôte et la machine cible en faisant le test d'un
ping unique (Test-Connection ComputerName $Target Count 1 ErrorActionStop | Out-Null).


Si la machine hote arrive à bien ping la machine cible, nous auront un retour du windows form label (un peu ci dessus nous disant que le ping a réussi.)
Dans cette fonction nous avons aussi la condition qui spécifie que si le ping réussi, il lance le second script ou se trouve les options client(& $Menu2 $Target).
Si le second script na pas été trouvé, il renverra donc un message qui explique que le second script n'a pas été trouvée :(Write-Host "Le script $Menu2 n'a pas été trouvé." # Message de débogage).
Si le ping échoue, le second script ne sera pas lancé et le label windows form nous indiquera sous les text box que le ping a échoué ( Write-Host "Échec de la connexion à $Target" # Message de débogage)
PS : les message de débogage ont été mis en place pour que certaines commandes du script fonctionne, car sans, nous rencontrions de gros problèmes.
(Notament des commandes qui n'étaient pas totalement prise en compte voir pas du tout.)
Nous enverrons également au deuxième script le nom machine ou l'adresse ip fourni pas l'utilisateur.
Nous nous en servirons donc en tant que condition de lancement du deuxième script (& $Menu2 $Target) que nous avons au préalable indiqué en tant que variable dans les event handler ci dessous.

7 . L'Event handler pour la connexion nom machine

![image](https://github.com/user-attachments/assets/976d7836-774b-44e8-97c2-5b27f053182e)
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

8 . Event handler pour la connexion IP

![image](https://github.com/user-attachments/assets/c772e3b7-0e50-4fe1-9920-b4505897b123)
<br>

dDns ce dernier bout de script nous allons créer le second event handeler.
celui ci agis exactement comme le premier, à la seul difference que celui-ci est programme une connexion via l'adresse ip de la machine cible.
Nous gérons donc ici le label d'affichage de résultat, savoir si la connexion à la machine a réussi ou échoué :
($Label.Text = "$Label2.Text = "Connexion à$AdresseIp réussie).qui sera ecrit en vert ($Label.ForeColor =System.Drawing.Color]::Green)
Si la connexion échoue, cela va renvoyer un message au label disant que la connexion échouée ($Label2.Text = "Connexion à $AdresseIp échouée).
Ce message sera par ailleurs affiché en rouge ($Label.ForeColor = System.Drawing.Color]::Red).
Comme pour le premier event handler,nous avons essayer d'implémenter une commande pour fermer la fenêtre du premier script lorsque que le second est lancée après un ping réussi.
Cependant, nous n'avons jusque la pas réussi à la faire fonctionner correctement."($Form.Close() # Ferme la fenêtre du premier script)"

9. Fin du script

![image](https://github.com/user-attachments/assets/578cfd5c-67f5-4bc2-b7f5-01ab0f78d0d9)


Nous aurons ici la fin du script en deux ligne qui comporte respectivement, une ligne pour l'affichage de la fenêtre en windows form($Form.ShowDialog()).
Et la deuxieme ligne pour renvoyer l'arret du script dans le terminal (Write-Log "Arrêt du script.)
<br>

Voila qui conclu ce premier script.
