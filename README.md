# Secure DevSecOps Infrastructure with IDS/IPS and CI/CD Pipeline

## Objectif
Construire une infrastructure DevSecOps securisee pour deployer une application web avec Docker, Nginx, CI/CD, monitoring, logging et controles de securite.

## Composants principaux
- Application web conteneurisee
- Docker / Docker Compose
- Nginx reverse proxy
- GitHub Actions pour CI/CD
- Prometheus + Grafana pour monitoring
- ELK / Wazuh pour logging
- UFW, ModSecurity, Suricata pour la securite

## Architecture resumee
Developer -> GitHub -> GitHub Actions -> VM -> Docker -> Nginx -> Application

## Structure du repository
- `app/` : code de l'application
- `infra/` : deployment, docker compose, scripts
- `nginx/` : configuration reverse proxy
- `monitoring/` : Prometheus, Grafana, exporters
- `security-notes/` : notes securite et tests
- `evidence/` : captures, preuves, exports
- `docs/` : documentation du projet
- `.github/workflows/` : pipelines CI/CD

## Repartition des roles
- Youssef : application, Docker, CI/CD, monitoring
- Ahmed : couche securite, WAF, firewall, IDS/IPS, logs securite
