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

