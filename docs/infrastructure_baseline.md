# Infrastructure Baseline

## Machine cible principale
- Nom: VM-Y1-AppServer
- Proprietaire: Youssef
- Role: Application Server
- Hyperviseur: VMware
- OS: Ubuntu Server 22.04 LTS
- IP: 192.168.56.20
- CPU: 2 vCPU
- RAM: 4 Go
- Disque: 35 Go
- Reseau: Host-Only + NAT

## Usage prevu
Cette machine servira de base pour:
- Docker
- application web
- scripts de deploiement
- tests locaux DevOps

## Acces administration
- SSH: OK / A verifier
- Utilisateur admin: your-admin-user
- Dossier projet: ~/project

## Verification technique
- Reboot teste: Oui 
- Reseau stable: Oui 
- Ping depuis le host: Oui 
- SSH apres reboot: Oui 
- Dossier projet possible: Oui 

## Notes
- La machine ne doit pas exposer directement l'application a Internet.
- Elle sera integree plus tard avec la gateway de securite et le monitoring.