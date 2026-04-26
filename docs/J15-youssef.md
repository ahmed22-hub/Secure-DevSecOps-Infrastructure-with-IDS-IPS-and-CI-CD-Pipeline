#  Day 15 — Deployment Baseline Documentation

##  Objective
Document the deployment base before adding security layers (WAF, IDS, Firewall).

This document explains:
- how to run the project
- available services
- network structure
- where to check logs

---

##  Services Overview

The system is composed of:

- web → Flask application (internal)
- nginx → Reverse proxy (public entry point)

---

##  Network Architecture

- public-network → accessible from outside (Nginx)
- internal-network → private (Flask + Nginx)

Flow:

User → Nginx → Flask

---

##  How to Run the Stack

1. Clone project

git clone <repo_url>
cd project/docker

2. Start services

docker compose up -d --build

3. Verify containers

docker ps

Expected:
- flask_app → running (healthy)
- nginx_proxy → running

---

##  Access

- HTTP: http://localhost
- HTTPS: https://localhost

---

##  Healthcheck

curl http://localhost/health

Expected:
{"status": "OK"}

---

## 📜 Logs

Flask logs:
docker logs flask_app

Nginx logs:
docker logs nginx_proxy

---

##  Checklist

- Containers running
- Application accessible
- Healthcheck OK
- Logs visible
- HTTPS working

---

##  Deployment Summary

- Docker Compose orchestration
- Nginx reverse proxy
- HTTPS enabled (self-signed)
- Network segmentation applied

---

##  Security Integration Notes

- Entry point: Nginx (80/443)
- Backend not directly exposed
- Logs available
- Ready for WAF / IDS

---

##  Conclusion

The deployment base is stable and ready for security layers.
