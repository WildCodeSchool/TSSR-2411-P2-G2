1. Script doc graph


Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#----------------------------------------------------------------
                                # Logs

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#----------------------------------------------------------------
                # Chemin du fichier de log principal

$LogFilePath = "C:\Users\Administrator\Desktop\p2droit\Logs\journal_script.log"

#----------------------------------------------------------------
           # Créer le dossier pour les logs s'il n'existe pas

if (!(Test-Path "C:\Users\Administrator\Desktop\p2droit\Logs")) {
    New-Item -ItemType Directory -Path "C:\Users\Administrator\Desktop\p2droit\Logs" | Out-Null
}

#----------------------------------------------------------------
            # Fonction pour écrire dans les journaux

function Write-Log {
    param (
        [string]$Message
    )
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogEntry = "$($Timestamp): $Message"  # Utilisation de la syntaxe avec $()

    # Tenter d'écrire dans le fichier de log avec gestion d'accès concurrent
    $retryCount = 0
    $maxRetries = 5
    $waitTime = 2 # en secondes

    while ($retryCount -lt $maxRetries) {
        try {
            # Essayer d'ajouter du contenu au fichier log sans écraser
            Add-Content -Path $LogFilePath -Value $LogEntry -ErrorAction Stop
            return # Sortir de la fonction si l'écriture réussit
        } catch {
            # Si le fichier est verrouillé, attendre et réessayer
            Write-Host "Le fichier de log est verrouillé, tentative de réécriture dans 2 secondes..."
            Start-Sleep -Seconds $waitTime
            $retryCount++
        }
    }

    # Si l'écriture échoue après plusieurs tentatives
    Write-Error "Impossible d'écrire dans le fichier de log après plusieurs tentatives : $LogFilePath"
}

Write-Log "Démarrage du script."

#----------------------------------------------------------------
                # Création de la fenêtre

$Form = New-Object System.Windows.Forms.Form
$Form.ClientSize = "380,300"
$Form.Text = "[Projet 2] Menu *croa*"

#----------------------------------------------------------------
            # Création des boutons de connexion

# Bouton de connexion pour nom machine
$Bouton = New-Object System.Windows.Forms.Button
$Bouton.Location = New-Object System.Drawing.Point(280,50)
$Bouton.Width = 80
$Bouton.Height = 40
$Bouton.Text = "Connexion"
$Form.Controls.Add($Bouton)

# Bouton de connexion pour IP
$Bouton2 = New-Object System.Windows.Forms.Button
$Bouton2.Location = New-Object System.Drawing.Point(280,120)
$Bouton2.Width = 80
$Bouton2.Height = 40
$Bouton2.Text = "Connexion"
$Form.Controls.Add($Bouton2)

#----------------------------------------------------------------
                  # Création des TextBox

# TextBox pour entrée du nom machine
$TextBox = New-Object System.Windows.Forms.TextBox
$TextBox.Location = New-Object System.Drawing.Point(30,60)
$TextBox.Width = 240
$Form.Controls.Add($TextBox)

# TextBox pour entrée de l'IP
$TextBox2 = New-Object System.Windows.Forms.TextBox
$TextBox2.Location = New-Object System.Drawing.Point(30,130)
$TextBox2.Width = 240
$Form.Controls.Add($TextBox2)

#----------------------------------------------------------------
                    # Textes indicatifs

# Label pour entrée du nom machine
$Labelsnm = New-Object System.Windows.Forms.Label
$Labelsnm.Location = New-Object System.Drawing.Point(30,35)
$Labelsnm.Size = New-Object System.Drawing.Size(400,20)
$Labelsnm.Text = "Veuillez renseigner le nom de la machine :"
$Form.Controls.Add($Labelsnm)

# Label pour entrée de l'IP
$Labelsip = New-Object System.Windows.Forms.Label
$Labelsip.Location = New-Object System.Drawing.Point(30,110)
$Labelsip.Size = New-Object System.Drawing.Size(400,20)
$Labelsip.Text = "Veuillez renseigner l'ip de la machine :"
$Form.Controls.Add($Labelsip)

#----------------------------------------------------------------
            # Labels pour afficher les résultats

# Label pour afficher le résultat du test de connexion (nom machine)
$Label = New-Object System.Windows.Forms.Label
$Label.Location = New-Object System.Drawing.Point(30,80)
$Label.Size = New-Object System.Drawing.Size(320,20)
$Label.Text = ""
$Form.Controls.Add($Label)

# Label pour afficher le résultat du test de connexion (IP)
$Label2 = New-Object System.Windows.Forms.Label
$Label2.Location = New-Object System.Drawing.Point(30,150)
$Label2.Size = New-Object System.Drawing.Size(320,20)
$Label2.Text = ""
$Form.Controls.Add($Label2)

#----------------------------------------------------------------
               # Fonction pour effectuer un ping

Function Testping 
{
    param (
        [string]$Target
    )
    $Menu2 = "C:\Users\Administrator\Desktop\p2droit\camille.ps1"

    try {
        # Teste la connexion en envoyant 1 paquet
        Write-Host "Test de la connexion à $Target..."  # Message de débogage
        Test-Connection -ComputerName $Target -Count 1 -ErrorAction Stop | Out-Null
        Write-Host "Ping vers $Target réussi."  # Message de débogage

        # Vérifie si le chemin du script est valide
        if (Test-Path $Menu2) {
            Write-Host "Le script $Menu2 existe, lancement."  # Message de débogage
            Write-Host "Tentative de lancement du script avec le paramètre $Target"
            
            # Ajout de messages de débogage pour vérifier l'appel du script
            Write-Host "Commande exécutée : & $Menu2 -Target $Target"
            
            # Exécute le script avec le paramètre
            & $Menu2 -Target $Target
            
            Write-Host "Le script a été lancé."
        } else {
            Write-Host "Le script $Menu2 n'a pas été trouvé."  # Message de débogage
            [System.Windows.Forms.MessageBox]::Show("Le script spécifié est introuvable : $Menu2", "Erreur")
        }
        # Si le ping réussit, retourne $true
        return $true 
    } catch {
        Write-Host "Échec de la connexion à $Target"  # Message de débogage
        Write-Host "Erreur : $_"  # Affiche l'erreur capturée
        return $false
    }
}

#----------------------------------------------------------------
        # Event handler pour la connexion nom machine

$Bouton.Add_Click({
    $NomMachine = $TextBox.text
    Write-Log "Tentative de connexion à la machine $NomMachine"
    if (TestPing -Target $NomMachine) {
        $Label.Text = "Connexion à $NomMachine réussie"
        $Label.ForeColor = [System.Drawing.Color]::Green
        Write-Log "Connexion à $NomMachine réussie"
        
        # On attend un peu pour s'assurer que l'interface utilisateur est mise à jour avant de fermer
        [System.Windows.Forms.Application]::DoEvents()
        #$Form.Close()  # Ferme la fenêtre du premier script
    } else {
        $Label.Text = "Connexion à $NomMachine échouée"
        $Label.ForeColor = [System.Drawing.Color]::Red
        Write-Log "Connexion à $NomMachine échouée"
    }
})


#----------------------------------------------------------------
        # Event handler pour la connexion IP

$Bouton2.Add_Click({
    $AdresseIp = $TextBox2.text
    Write-Log "Tentative de connexion à l'adresse IP $AdresseIp"
    if (TestPing -Target $AdresseIp) {
        $Label2.Text = "Connexion à $AdresseIp réussie"
        $Label2.ForeColor = [System.Drawing.Color]::Green
        Write-Log "Connexion à $AdresseIp réussie"
        
        # On attend un peu pour s'assurer que l'interface utilisateur est mise à jour avant de fermer
        [System.Windows.Forms.Application]::DoEvents()
        #$Form.Close()  # Ferme la fenêtre du premier script
    } else {
        $Label2.Text = "Connexion à $AdresseIp échouée"
        $Label2.ForeColor = [System.Drawing.Color]::Red
        Write-Log "Connexion à $AdresseIp échouée"
    }
})

#----------------------------------------------------------------
                    # Affichage de la fenêtre

$Form.ShowDialog()

#----------------------------------------------------------------
                         # Fin du script

Write-Log "Arrêt du script."


2. Script Camille.ps1


#----------------------------------------------------------------
                 #récuperation du nom machine/ip

                 param (
                    [string]$Target
                )
                
                # Ajout de messages de débogage pour vérifier la réception du paramètre
                Write-Host "Début du script camille.ps1"
                Write-Host "Cible reçue : $Target"
                
                # Initialisation des variables globales
                $global:Cible = $Target
                $global:Utilisateur = "wilder"
#----------------------------------------------------------------
                    #import du module SSH

                    Import-Module Posh-SSH

                    Add-Type -AssemblyName System.Windows.Forms
#----------------------------------------------------------------
                # Chemin du fichier de log

$LogFilePath = "C:\Users\Administrator\Desktop\p2droit\Logs\journal_script2.log"
if (!(Test-Path "C:\Users\Administrator\Desktop\p2droit\Logs")) {
    New-Item -ItemType Directory -Path "C:\Users\Administrator\Desktop\p2droit\Logs" | Out-Null
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

$mdp = Read-Host -AsSecureString "`nVeuillez renseigner le mot de passe de la cible : $Target."

#----------------------------------------------------------------
                    # Crée un PSCredential

$Credential = New-Object System.Management.Automation.PSCredential($global:Utilisateur, $mdp)  # Remplacez "username" par le nom d'utilisateur approprié

#----------------------------------------------------------------
                    # crée un séssion ssh

# $session = New-SSHSession -ComputerName $Target -Credential $Credential -ConnectionTimeout 5 -ErrorAction SilentlyContinue
try {
    Write-Host "Tentative de connexion SSH à $global:Cible..."
    Write-Host "Nom d'utilisateur : $($credential.UserName)"
    Write-Host "Mot de passe : $($credential.GetNetworkCredential().Password)"  # Note: Ne pas afficher les mots de passe en production

    $session = New-SSHSession -ComputerName $global:Cible -Credential $credential -ConnectionTimeout 5 -ErrorAction Stop
    if ($session) {
        Write-Host "[Succès] Connexion réussie !" -ForegroundColor Green
        Write-Host "Session ID: $($session.SessionId)"
    } else {
        Write-Host "[Erreur] La connexion SSH a échoué sans générer d'erreur." -ForegroundColor Red
        throw "$global:Cible"
    }
} catch {
    Write-Host "[Erreur] Echec de la connexion à : $_" -ForegroundColor Red
    exit 1
}

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
    $desktopPath = "C:\Users\Administrator\Desktop\p2droit"
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
$btnOSVersion.Text = "Dernière version de l'OS"
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
    Write-Host "Récuperation de la version de l'os via SSH..."
    $result = Invoke-SSHCommand -SessionId $session.SessionId -Command "wmic os get Caption"
    if ($result.ExitStatus -eq 0) {
        $osVersion = $result.Output -replace 'Caption\s*', '' -replace '\s+', ' ' -replace '^\s+|\s+$', ''
        Write-Host "Dernière version de l'OS : $osVersion"
        $txtResult.Text = "Dernière version de l'OS : $osVersion"
        Save-Result -Content $txtResult.Text
    } else {
        Write-Host "Erreur lors de la récupération de la version de l'OS : $($result.Error)"
        $txtResult.Text = "Erreur lors de la récupération de la version de l'OS"
    }
})

#------------------------------

#Event handler nom machine
$btnComputerName.Add_Click({
    Write-Host "Récuperation du nom de l'ordinateur via SSH..."
    $result = Invoke-SSHCommand -SessionId $session.SessionId -Command "hostname"
    if ($result.ExitStatus -eq 0) {
        Write-Host "Résultat nom de l'ordinateur: $($result.Output)"
        $txtResult.Text = "Nom de l'ordinateur : $($result.Output)"
        Save-Result -Content $txtResult.Text
    } else {
        Write-Host "Erreur lors de la récupération du nom de l'ordinateur: $($result.Error)"
        $txtResult.Text = "Erreur lors de la récupération du nom de l'ordinateur"
    }
})

#------------------------------

#Event handler adresse ip
$btnIPAddress.Add_Click({
    Write-Host "récupération de l'adresse IP via SSH..."
    $result = Invoke-SSHCommand -SessionId $session.SessionId -Command "powershell -Command `"ipconfig | findstr 'IPv4 Address'`""
    if ($result.ExitStatus -eq 0) {
        $ipAddresses = $result.Output -split "`n" | ForEach-Object { $_.Trim() -replace '.*:\s*', '' }
        $formattedIPAddresses = $ipAddresses -join "`n"
        Write-Host "Résultat adresse IP: $formattedIPAddresses"
        $txtResult.Text = "Adresse IP cible : `n$formattedIPAddresses"
        Save-Result -Content $txtResult.Text
    } else {
        Write-Host "Erreur lors de la récupération de l'adresse IP: $($result.Error)"
        $txtResult.Text = "Erreur lors de la récupération de l'adresse IP"
    }
})

#------------------------------

#Event handler information machine
$btnInfoBatchCible.Add_Click({
    Write-Host "Récuperation de la version de l'os via SSH..."
    $osVersion = Invoke-SSHCommand -SessionId $session.SessionId -Command "powershell -Command 'wmic os get Caption'"
    Write-Host "Récuperation du nom de l'ordinateur via SSH..."
    $computerName = Invoke-SSHCommand -SessionId $session.SessionId -Command "hostname"
    Write-Host "récupération de l'adresse IP via SSH..."
    $ipAddress = Invoke-SSHCommand -SessionId $session.SessionId -Command "powershell -Command `"ipconfig | findstr 'IPv4 Address'`""

    if ($osVersion.ExitStatus -eq 0 -and $computerName.ExitStatus -eq 0 -and $ipAddress.ExitStatus -eq 0) {
        $osVersionClean = $osVersion.Output -replace 'Caption\s*', '' -replace '\s+', ' ' -replace '^\s+|\s+$', ''
        $ipAddressClean = $ipAddress.Output -split "`n" | ForEach-Object { $_.Trim() -replace '.*:\s*', '' }
        $content = "Dernière version de l'OS : $osVersionClean`nNom de l'ordinateur : $($computerName.Output)`nAdresse IP actuelle : $ipAddressClean"
        Write-Host "Information Result: $content"
        Save-Result -Content $content
    } else {
        Write-Host "Erreur lors de la récupération de la version de l'OS: $($osVersion.Error), nom de l'ordinateur: $($computerName.Error), adresse IP: $($ipAddress.Error)"
        $txtResult.Text = "Erreur lors de la récupération des informations de la machine"
    }
})

#------------------------------

#Event handler pour arret machine
$Boutonstop.Add_Click({ 
    if ($null -eq $session.SessionId) {
        Write-Host "La session est null.s'il vous plait initialisée la session."
    } else {
        Write-Host "Arret de l'ordinateur via SSH..."
        Invoke-SSHCommand -SessionId $session.SessionId -Command "shutdown /s /t 0"
    }
})

#------------------------------

#Event handler pour reboot machine
$Boutonreboot.Add_Click({ 
    if ($null -eq $session.SessionId) {
        Write-Host "La session est null.s'il vous plait initialisée la session."
    } else {
        Write-Host "Redémarrage de l'ordinateur via SSH..."
        Invoke-SSHCommand -SessionId $session.SessionId -Command "shutdown /r /t 0"
    }
})

#----------------------------------------------------------------
            # Actions des sous-boutons Utilisateur

#Event handler nom utilisateur
$btnUserName.Add_Click({
    if ($null -eq $session.SessionId) {
        Write-Host "La session est null.s'il vous plait initialisée la session."
    } else {
        $command = 'powershell -Command "$env:USERNAME"'
        $result = Invoke-SSHCommand -SessionId $session.SessionId -Command $command
        if ($result.ExitStatus -eq 0) {
            $userName = $result.Output -join "`n"
            $txtResult.Text = "Nom de l'utilisateur : $userName"
            Save-Result -Content $txtResult.Text
        } else {
            Write-Host "Error: $($result.Error)"
            $txtResult.Text = "Erreur lors de la récupération du nom d'utilisateur."
        }
    }
})

#------------------------------

#Event handler derniere connexion
$btnLastLogin.Add_Click({
    if ($null -eq $session.SessionId) {
        Write-Host "La session est null.s'il vous plait initialisée la session."
    } else {
        $command = 'powershell -Command "(Get-EventLog -LogName Security -Newest 1 -InstanceId 4624).TimeGenerated"'
        $result = Invoke-SSHCommand -SessionId $session.SessionId -Command $command
        if ($result.ExitStatus -eq 0) {
            $lastLogin = $result.Output -join "`n"
            $txtResult.Text = "Dernière connexion : $lastLogin"
            Save-Result -Content $txtResult.Text
        } else {
            Write-Host "Erreur: $($result.Error)"
            $txtResult.Text = "Erreur lors de la récupération de la dernière connexion."
        }
    }
})

#------------------------------

#Event handler liste utilisateur
$btnUserList.Add_Click({
    if ($null -eq $session.SessionId) {
        Write-Host "La session est null.s'il vous plait initialisée la session."
    } else {
        $command = 'powershell -Command "net user | Out-String"'
        $result = Invoke-SSHCommand -SessionId $session.SessionId -Command $command
        if ($result.ExitStatus -eq 0) {
            $userList = $result.Output -join "`n"
            $txtResult.Text = "Liste des utilisateurs locaux : `n$userList"
            Save-Result -Content $txtResult.Text
        } else {
            Write-Host "Erreur: $($result.Error)"
            $txtResult.Text = "Erreur lors de la récupération de la liste des utilisateurs."
        }
    }
})

#------------------------------

#Event handler information utilisateur
$btnInfoBatchUtilisateur.Add_Click({
    if ($null -eq $session.SessionId) {
        Write-Host "La session est null.s'il vous plait initialisée la session."
    } else {
        Write-Host "Récuperation du nom de l'utilisateur."
        $userNameCommand = 'powershell -Command "$env:USERNAME"'
        $userNameResult = Invoke-SSHCommand -SessionId $session.SessionId -Command $userNameCommand
        if ($userNameResult.ExitStatus -eq 0) {
            $userName = $userNameResult.Output -join "`n"
        } else {
            Write-Host "Erreur lors de la récupération du nom d'utilisateur: $($userNameResult.Error)"
            $userName = "Erreur lors de la récupération du nom d'utilisateur."
        }

        Write-Host "récuperation de la dernière connexion."
        $lastLoginCommand = 'powershell -Command "(Get-EventLog -LogName Security -Newest 1 -InstanceId 4624).TimeGenerated"'
        $lastLoginResult = Invoke-SSHCommand -SessionId $session.SessionId -Command $lastLoginCommand
        if ($lastLoginResult.ExitStatus -eq 0) {
            $lastLogin = $lastLoginResult.Output -join "`n"
        } else {
            Write-Host "Erreur lors de la récupération de la dernière connexion: $($lastLoginResult.Error)"
            $lastLogin = "Erreur lors de la récupération de la dernière connexion."
        }

        Write-Host "recuperation de la liste des utilisateurs."
        $userListCommand = 'powershell -Command "net user | Out-String"'
        $userListResult = Invoke-SSHCommand -SessionId $session.SessionId -Command $userListCommand
        if ($userListResult.ExitStatus -eq 0) {
            $userList = $userListResult.Output -join "`n"
        } else {
            Write-Host "Erreur lors de la récupération de la liste des utilisateurs: $($userListResult.Error)"
            $userList = "Erreur lors de la récupération de la liste des utilisateurs."
        }

        $content = "Nom de l'utilisateur : $userName`nDernière connexion : $lastLogin`nListe des utilisateurs locaux :`n$userList"
        Save-Result -Content $content
    }
})

#------------------------------

#Event handler pour création utilisateur
$Boutoncu.Add_Click({
    if ($null -eq $session.SessionId) {
        Write-Host "La session est null.s'il vous plait initialisée la session."
    } else {
        $nomnewuser = $TextBox3.Text
        Write-Host "Création de l'utilisateur: $nomnewuser"
        $command = "powershell -Command `"New-LocalUser -Name `"$nomnewuser`" -NoPassword`""
        Write-Host "Executing command: $command"
        $result = Invoke-SSHCommand -SessionId $session.SessionId -Command $command
        if ($result.ExitStatus -eq 0) {
            Write-Host "utilisateur crée avec succes."
            $txtResult.Text = "Utilisateur '$nomnewuser' créé avec succès."
            Save-Result -Content $txtResult.Text
        } else {
            Write-Host "Erreur: $($result.Error)"
            $txtResult.Text = "Erreur lors de la création de l'utilisateur '$nomnewuser'."
        }
    }
})

#------------------------------

#Event handler pour suppression utilisateur
$Boutondu.Add_Click({
    if ($null -eq $session.SessionId) {
        Write-Host "La session est null.s'il vous plait initialisée la session."
    } else {
        $nomdeluser = $TextBox3.Text
        Write-Host "suppression de l'utilisateur: $nomdeluser"
        $command = "powershell -Command `"Remove-LocalUser -Name '$nomdeluser'`""
        Write-Host "Executing command: $command"
        $result = Invoke-SSHCommand -SessionId $session.SessionId -Command $command
        if ($result.ExitStatus -eq 0) {
            Write-Host "Utilisateur supprimé avec succès."
            $txtResult.Text = "Utilisateur '$nomdeluser' supprimé avec succès."
            Save-Result -Content $txtResult.Text
        } else {
            Write-Host "Error: $($result.Error)"
            $txtResult.Text = "Erreur lors de la suppression de l'utilisateur '$nomdeluser'."
        }
    }
})

#----------------------------------------------------------------
                    # Affichage de la fenetre

[void]$form.ShowDialog()

#----------------------------------------------------------------
# stop la transcription dans les logs pour ce script

Stop-Transcript
camille.ps1
23 Ko
