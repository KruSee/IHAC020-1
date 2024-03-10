
# Cheat sheet NMAP
## Introduction à NMAP
 Nmap (Network Mapper) est un outil de scan de réseau open-source utilisé pour découvrir les hôtes et les services sur un réseau informatique. Il est largement utilisé par les administrateurs système et les chercheurs en sécurité pour sécuriser les réseaux et détecter les vulnérabilités.

## Analyse d'IP

nmap 192.168.1.1  
#### Analyser une seule IP

nmap 192.168.1.1-254  
#### Analyser une plage d'IP

nmap scanme.nmap.org  
#### Analyser un domaine

nmap -iL targets.txt  
 #### Analyser les cibles depuis un fichier

nmap --exclude 192.168.1.1  Exclure les hôtes de la liste


## Techniques de Scan Nmap

nmap 192.168.1.1 -sS  
#### Analyse de port TCP SYN (par défaut)

nmap 192.168.1.1 -sT  
#### Analyse de port TCP connect (sans privilège root)

nmap 192.168.1.1 -sU  
#### Analyse de port UDP

nmap 192.168.1.1 -sA  
#### Analyse de port TCP ACK


## Découverte d'Hôtes

nmap 192.168.1.1-3 -sL  
Listez les cibles sans nal

nmap 192.168.1.1/24 -sn  
#### Désactiver l'analyse de port, découverte d'hôtes seulement.

nmap 192.168.1.1-5 -Pn  
#### Désactiver la découverte d'hôtes, analyse de ports seulement.

nmap 192.168.1.1-5 -PS22-25,80  
#### Découverte TCP SYN sur le port spécifié ( 80 par défaut)

nmap 192.168.1.1-1/24 -PR  
#### Découverte ARP sur le réseau local

nmap 192.168.1.1 -n  
####Ne jamais résoudre les noms DNS


## Spécification des Ports
nmap 192.168.1.1 -p 21  
#### Analyse du port spécifié

nmap 192.168.1.1 -p 21-100  
#### Plage de ports

nmap 192.168.1.1 -p -  
#### Analyse de tous les ports



Détection de Services et de Versions
nmap 192.168.1.1 -sV  
#### Tente de déterminer la version du service en cours d'exécution sur le port

nmap 192.168.1.1 -A  
#### Active la détection d'OS, la détection de version