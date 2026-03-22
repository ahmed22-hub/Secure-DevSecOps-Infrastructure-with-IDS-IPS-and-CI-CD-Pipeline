# DevSecOps Project Vision

## Objective

Build a secure infrastructure to deploy a web application using DevSecOps practices.

---

## Project Components

- Web Application (Flask / Node.js)
- Docker (containerization)
- Docker Compose (orchestration)
- Nginx (reverse proxy)
- CI/CD (GitHub Actions)
- Monitoring (Prometheus + Grafana)
- Logging (Wazuh / ELK)
- Security:
  - Firewall (UFW)
  - WAF (ModSecurity)
  - IDS/IPS (Suricata)

---

## Deployment Flow

Developer → GitHub → CI/CD Pipeline → Server → Docker → Nginx → Application

---

## DevOps Goals

- Reproducibility (Docker)
- Automation (CI/CD)
- Monitoring (Prometheus/Grafana)
- Reliable deployment