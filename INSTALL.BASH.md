# 📚 Documentation Admin
### 📂 projet2.sh
---
### **📑 Sommaire**
- [📝 Présentation](#presentation)
- [🛠️ Installation & Prérequis](#installation)
- [📊 Variables](#variables)
- [📝 Journalisation](#log-event)
- [🌐 Vérification IP](#check-ip)
- [👥 Gestion Utilisateur ](#user-management-menu)
- [⚙️ Gestion Système](#system-management-menu)
- [🎯 Gestion de la Cible](#target-menu)
- [🔑 Menu Principal](#main-menu)
---

### **📝 Présentation Script**
<span id="presentation"></span>
Ce script permet de gérer des connexions SSH à des machines distantes, de gérer les utilisateurs et les paramètres système via une interface graphique (whiptail).
Il permet de se connecter à une machine via IP, de gérer les utilisateurs et d'effectuer des opérations système comme arrêter ou redémarrer la machine.

Le script utilise **6** fonctions principales et un tout en haut du script on a défini les variables pour le script. Voici une description de chaque élément :

**Fonctions** :
- `log_event` : Cette fonction enregistre des événements dans un fichier de log, y compris la date, l'heure, l'utilisateur et l'événement qui a eu lieu.
- `check_ip()` : Vérifie la connectivité à une machine distante via son adresse IP et permet une connexion SSH si l'IP est accessible.
- `user_management_menu()` : Permet de gérer les utilisateurs d'une machine distante (ajouter, supprimer, lister les utilisateurs).
- `system_management_menu()` : Permet de gérer les paramètres système d'une machine distante (arrêter, redémarrer la machine, afficher des informations système).
- `target_menu()` : Propose un menu permettant de choisir entre la gestion des utilisateurs ou du système pour une machine distante.
- `main_menu()` : Le menu principal du script, permettant de sélectionner une option pour vérifier l'IP et se connecter à une machine distante ou quitter.
---
### **🛠️ Installation & Prérequis**
<span id="installation"></span>
- **Système d'exploitatition:**
   - Client Linux (Debian, Ubuntu, etc...)
- **Accès admin sur le système.**
- **Avoir une connexion à internet stable sur la machine.**

Pour faire fonctionner le script, il faudra que tu installes l'outil `sshpass` via l'invite de commande. Pour ce faire, tu auras juste à exécuter cette commande :
```bash
sudo apt install sshpass
```
---
### **📊 Variables**
<span id="variables"></span>
Donc ici, on définit le shebang pour que notre shell interprète correctement le script, et nous définissons aussi les variables que nous réutiliserons plus tard dans le script.
```bash
#!/bin/bash

LOG_FILE="/tmp/logs.txt" // certaines logs de log_evt_file vont dans celui là aussi
LOG_EVT_FILE="$HOME/Documents/log_evt.log"
TARGET_INFO_DIR="/var/log/"
```
---
### **📝 Journalisation**
<span id="log-event"></span>
Dans cette fonction, nous récupérons un événement passé en paramètre et nous y ajoutons la date, l'heure et le nom de l'utilisateur courant. Ces informations sont ensuite formatées et enregistrées dans le fichier de logs spécifié par la variable `LOG_EVT_FILE`, afin d'avoir un suivi de logs du script.

`log_event`:
```bash
log_event() {
    EVENT="$1"
    DATE=$(date +%Y%m%d)
    TIME=$(date +%H%M%S)
    USER=$(whoami)
    echo "$DATE-$TIME-$USER-$EVENT" >> "$LOG_EVT_FILE"
}
```
---
### **🌐 Vérification IP**
<span id="check-ip"></span>
Dans cette fonction, nous récupérons l'adresse IP passée en paramètre et vérifions si la cible est accessible en utilisant la commande `ping`. Si l'IP est joignable, nous demandons à l'utilisateur de saisir un mot de passe pour se connecter en SSH. Si la connexion SSH est réussie, un message de confirmation s'affiche et l'utilisateur est dirigé vers un autre menu. Sinon, des messages d'erreur sont affichés et les événements sont enregistrés dans les logs. Si l'IP n'est pas joignable, un message d'erreur est également affiché.

`check_ip`:
```bash
check_ip() {
    IP="$1"
    
    if ping -c 1 "$IP" &>/dev/null; then
        PASSWORD=$(whiptail --title "Saisie du mot de passe" --passwordbox "Entrez le mot de passe pour SSH à $IP" 8 40 3>&1 1>&2 2>&3)
        if [[ -n "$PASSWORD" ]]; then
            if sshpass -p "$PASSWORD" ssh -o ConnectTimeout=5 administrq@"$IP" exit &>/dev/null; then
                whiptail --title "Connexion réussie" --msgbox "Connexion SSH réussie à $IP" 8 40
                log_event "Connexion SSH réussie à $IP"
                target_menu "$IP" "$PASSWORD"
            else
                whiptail --title "Erreur SSH" --msgbox "Impossible de se connecter en SSH à la cible $IP." 8 40
                log_event "Échec de connexion SSH à $IP"
            fi
        else
            whiptail --title "Erreur" --msgbox "Mot de passe vide, veuillez réessayer." 8 40
            log_event "Mot de passe vide pour SSH à $IP"
        fi
    else
        whiptail --title "Erreur de connexion" --msgbox "La cible $IP n'est pas joignable." 8 40
        log_event "La cible $IP n'est pas joignable"
    fi
}
---
```
### **👥 Gestion Utilisateur**
<span id="user-management-menu"></span>
Cette fonction affiche un menu pour gérer les utilisateurs sur une machine distante via SSH. Elle utilise whiptail pour afficher un menu interactif en ligne de commande. Selon l'option choisie, elle effectue différentes actions sur la machine distante, telles que l'ajout ou la suppression d'utilisateurs, la consultation de la liste des utilisateurs, ou la consultation de la dernière connexion d'un utilisateur.

### **⚠️ Attention**
**Tu ne dois pas oublier de modifier dans cette fonction le `administrq@` par le bon utilisateur.**

`user_management_menu`:
```bash
user_management_menu() {
    IP="$1"
    PASSWORD="$2"
    
    while true; do
        ADVSEL=$(whiptail --title "Gestion des utilisateurs" --menu "Choisissez une action pour la machine distante $IP" 15 60 5 \
        "1" "Lister les utilisateurs" \
        "2" "Ajouter un utilisateur" \
        "3" "Supprimer un utilisateur" \
        "4" "Dernière date de connexion du user" \
        "5" "Retour" 3>&1 1>&2 2>&3)

        case $ADVSEL in
            1)
                RESULT=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "cut -d: -f1 /etc/passwd")
                echo "$(date): Liste des utilisateurs : $RESULT" >> "$LOG_FILE"
                whiptail --title "Liste des utilisateurs" --msgbox "Utilisateurs sur $IP:\n$RESULT" 15 60

                INFO_FILE="$TARGET_INFO_DIR/info_$(basename "$IP")_$(date +%Y%m%d).txt"
                echo "Liste des utilisateurs sur $IP" > "$INFO_FILE"
                echo "$RESULT" >> "$INFO_FILE"
                log_event "Liste des utilisateurs pour $IP enregistrée dans $INFO_FILE"
                ;;

            2)
                USERNAME=$(whiptail --title "Ajouter un utilisateur" --inputbox "Entrez le nom de l'utilisateur à ajouter:" 10 50 3>&1 1>&2 2>&3)
                if [[ -n "$USERNAME" ]]; then
                    EXISTING_USER=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "getent passwd $USERNAME")
                    if [[ -n "$EXISTING_USER" ]]; then
                        whiptail --title "Erreur" --msgbox "L'utilisateur $USERNAME existe déjà sur $IP." 8 40
                        log_event "Tentative d'ajout de l'utilisateur $USERNAME, mais il existe déjà sur $IP"
                    else
                        RESULT=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "echo '$PASSWORD' | sudo -S useradd $USERNAME 2>&1")
                        if [[ $? -eq 0 ]]; then
                            echo "$(date): Utilisateur ajouté : $USERNAME" >> "$LOG_FILE"
                            whiptail --title "Utilisateur ajouté" --msgbox "L'utilisateur $USERNAME a été ajouté sur $IP." 8 40
                            log_event "Utilisateur $USERNAME ajouté sur $IP"
                        else
                            whiptail --title "Erreur d'ajout" --msgbox "Erreur lors de l'ajout de l'utilisateur $USERNAME sur $IP.\n$RESULT" 8 40
                            log_event "Erreur lors de l'ajout de l'utilisateur $USERNAME sur $IP"
                        fi
                    fi
                else
                    whiptail --title "Erreur" --msgbox "Aucun nom d'utilisateur fourni." 8 40
                    log_event "Aucun nom d'utilisateur fourni pour ajout sur $IP"
                fi
                ;;

            3)
                USERNAME=$(whiptail --title "Supprimer un utilisateur" --inputbox "Entrez le nom de l'utilisateur à supprimer:" 10 50 3>&1 1>&2 2>&3)
                if [[ -n "$USERNAME" ]]; then
                    EXISTING_USER=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "getent passwd $USERNAME")
                    if [[ -z "$EXISTING_USER" ]]; then
                        whiptail --title "Erreur" --msgbox "L'utilisateur $USERNAME n'existe pas sur $IP." 8 40
                        log_event "L'utilisateur $USERNAME n'existe pas sur $IP"
                    else
                        ACTIVE_PROCESSES=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "ps -u $USERNAME -o pid=")
                        if [[ -n "$ACTIVE_PROCESSES" ]]; then
                            echo "$(date): Tentative de suppression des processus de $USERNAME" >> "$LOG_FILE"
                            for PID in $ACTIVE_PROCESSES; do
                                sshpass -p "$PASSWORD" ssh administrq@"$IP" "echo '$PASSWORD' | sudo -S kill -9 $PID"
                                if [[ $? -eq 0 ]]; then
                                    echo "$(date): Processus $PID tué avec succès." >> "$LOG_FILE"
                                else
                                    echo "$(date): Impossible de tuer le processus $PID." >> "$LOG_FILE"
                                    whiptail --title "Erreur" --msgbox "Impossible de tuer le processus PID $PID." 8 40
                                fi
                            done
                        fi

                        RESULT=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "echo '$PASSWORD' | sudo -S userdel -r $USERNAME 2>&1")
                        if [[ $? -eq 0 ]]; then
                            echo "$(date): Utilisateur supprimé : $USERNAME" >> "$LOG_FILE"
                            whiptail --title "Utilisateur supprimé" --msgbox "L'utilisateur $USERNAME a été supprimé sur $IP." 8 40
                            log_event "Utilisateur $USERNAME supprimé sur $IP"
                        else
                            whiptail --title "Erreur de suppression" --msgbox "Erreur lors de la suppression de l'utilisateur $USERNAME sur $IP.\n$RESULT" 8 40
                            log_event "Erreur lors de la suppression de l'utilisateur $USERNAME sur $IP"
                        fi
                    fi
                else
                    whiptail --title "Erreur" --msgbox "Aucun nom d'utilisateur fourni." 8 40
                    log_event "Aucun nom d'utilisateur fourni pour suppression sur $IP"
                fi
                ;;

            4)
                USERNAME=$(whiptail --title "Dernière connexion" --inputbox "Entrez le nom de l'utilisateur:" 10 50 3>&1 1>&2 2>&3)
                if [[ -n "$USERNAME" ]]; then
                    LAST_LOGIN=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "lastlog -u $USERNAME")
                    whiptail --title "Dernière connexion" --msgbox "Dernière connexion pour $USERNAME sur $IP:\n$LAST_LOGIN" 15 60
                    log_event "Dernière connexion de l'utilisateur $USERNAME sur $IP : $LAST_LOGIN"
                else
                    whiptail --title "Erreur" --msgbox "Aucun nom d'utilisateur fourni." 8 40
                    log_event "Aucun nom d'utilisateur fourni pour la consultation de la dernière connexion sur $IP"
                fi
                ;;

            5)
                break
                ;;

            *)
                whiptail --title "Erreur" --msgbox "Option invalide." 8 40
                log_event "Option invalide dans le menu de gestion des utilisateurs sur $IP"
                ;;
        esac
    done
}
```
### **⚙️ Gestion Système**
<span id="system-management-menu"></span>
Cette fonction affiche un menu pour gérer le système d'une machine distante via SSH. Elle permet de réaliser plusieurs actions sur la machine distante, telles que l'arrêt, le redémarrage, l'affichage du nom de l'ordinateur, l'adresse IP, la version de l'OS, ou obtenir des informations système complètes.

### **⚠️ Attention**
**Tu ne dois pas oublier de modifier dans cette fonction le `administrq@` par le bon utilisateur.**

`system_management_menu`:
```bash
system_management_menu() {
    IP="$1"
    PASSWORD="$2"
    
    while true; do
        ADVSEL=$(whiptail --title "Gestion du système" --menu "Choisissez une action pour la machine distante $IP" 15 60 6 \
        "1" "Arrêter la machine" \
        "2" "Redémarrer la machine" \
        "3" "Nom de l'ordinateur" \
        "4" "Adresse IP de l'ordinateur" \
        "5" "Dernière version de l'OS" \
        "6" "Toutes les infos système" \
        "7" "Retour" 3>&1 1>&2 2>&3)

        case $ADVSEL in
            1)
                RESULT=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "echo '$PASSWORD' | sudo -S shutdown now 2>&1")
                whiptail --title "Arrêt" --msgbox "Machine arrêtée sur $IP." 8 40
                log_event "Machine arrêtée sur $IP : $RESULT"
                ;;

            2)
                RESULT=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "echo '$PASSWORD' | sudo -S reboot 2>&1")
                whiptail --title "Redémarrage" --msgbox "Machine redémarrée sur $IP." 8 40
                log_event "Machine redémarrée sur $IP : $RESULT"
                ;;

            3)
                HOSTNAME=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "hostname")
                whiptail --title "Nom de l'ordinateur" --msgbox "Nom de l'ordinateur : $HOSTNAME" 8 40
                log_event "Nom de l'ordinateur sur $IP : $HOSTNAME"
                ;;

            4)
                IP_ADDR=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "hostname -I")
                whiptail --title "Adresse IP" --msgbox "Adresse IP : $IP_ADDR" 8 40
                log_event "Adresse IP de l'ordinateur sur $IP : $IP_ADDR"
                ;;

            5)
                OS_VERSION=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "lsb_release -a")
                whiptail --title "Version de l'OS" --msgbox "Dernière version de l'OS :\n$OS_VERSION" 15 60
                log_event "Dernière version de l'OS sur $IP : $OS_VERSION"
                ;;

            6)
                SYSTEM_INFO=$(sshpass -p "$PASSWORD" ssh administrq@"$IP" "hostname -I; hostname; lsb_release -a")
                whiptail --title "Informations système" --msgbox "Informations système sur $IP :\n$SYSTEM_INFO" 15 60
                log_event "Toutes les informations système pour $IP : $SYSTEM_INFO"
                ;;

            7)
                break
                ;;

            *)
                whiptail --title "Erreur" --msgbox "Option invalide." 8 40
                log_event "Option invalide dans le menu de gestion du système pour $IP"
                ;;
        esac
    done
}
```
---
### **🎯 Gestion de la Cible**
<span id="target-menu"></span>

La fonction target_menu présente un menu avec des options pour gérer un hôte distant. Elle permet à l'utilisateur de choisir entre plusieurs actions, telles que la gestion des utilisateurs, la gestion du système, ou un retour. Cette fonction appelle également d'autres fonctions (`user_management_menu` et `system_management_menu`) en fonction des choix de l'utilisateur.

### **⚠️ Attention**
**Tu ne dois pas oublier de modifier dans cette fonction le `administrq@` par le bon utilisateur.**

`target_menu`:
```bash
target_menu() {
    IP="$1"
    PASSWORD="$2"

    while true; do
        ADVSEL=$(whiptail --title "Menu Cible" --menu "Choisissez une option pour $IP" 15 60 6 \
        "1" "Gestion des utilisateurs" \
        "2" "Gestion du système" \
        "3" "Retour" 3>&1 1>&2 2>&3)

        case $ADVSEL in
            1)
                user_management_menu "$IP" "$PASSWORD"
                ;;

            2)
                system_management_menu "$IP" "$PASSWORD"
                ;;

            3)
                break
                ;;

            *)
                whiptail --title "Erreur" --msgbox "Option invalide." 8 40
                log_event "Option invalide dans le menu cible pour $IP"
                ;;
        esac
    done
}
```
---
### **📚 Menu Principal**
<span id="main-menu"></span>
Dans cette fonction, nous affichons un menu principal avec deux options : vérifier la connexion via IP ou quitter. Si l'utilisateur choisit de vérifier une IP, il est invité à entrer l'adresse IP de la machine distante. Si une IP valide est fournie, la fonction check_ip est appelée pour vérifier la connectivité. Si l'IP est vide, un message d'erreur est affiché et l'événement est enregistré dans les logs. Si l'utilisateur choisit de quitter, le script se termine. En cas de choix invalide, un message d'erreur est affiché et l'événement est également consigné dans les logs.

### **ℹ️ Information**
**Le dernier `main_menu` dans le script sert à démarrer le menu principal lorsque le script est exécuté. Cette ligne n'est pas dans une fonction.**

`main_menu`:
```bash
main_menu() {
    ADVSEL=$(whiptail --title --fb --menu "Sélectionne une option" 15 60 3 \
    "1" "Vérifier via IP et se connecter sur la cible." \
    "2" "Quitter" 3>&1 1>&2 2>&3)

    case $ADVSEL in
        1)
            IP=$(whiptail --title "Saisie de l'IP" --inputbox "Entrez l'adresse IP de la machine distante" 10 50 3>&1 1>&2 2>&3)
            if [[ -n "$IP" ]]; then
                check_ip "$IP"
            else
                whiptail --title "Erreur" --msgbox "Aucune IP fournie." 8 40
                log_event "Aucune IP fournie pour la vérification"
            fi
            ;;

        2)
            exit 0
            ;;

        *)
            whiptail --title "Erreur" --msgbox "Option invalide." 8 40
            log_event "Option invalide dans le menu principal"
            ;;

    esac
}

main_menu # cette ligne n'est pas dans la fonction
```
