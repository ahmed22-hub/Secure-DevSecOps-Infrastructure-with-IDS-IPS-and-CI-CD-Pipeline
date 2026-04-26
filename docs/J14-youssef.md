#  Day 14 — HTTPS Preparation and Configuration

##  Objective
Provide a clear path to secure web access using HTTPS. Implement a basic TLS setup or document the plan.

---

##  Concept
HTTP is not encrypted. HTTPS adds TLS encryption to protect data in transit.

Before:
User → HTTP (port 80) → Nginx → App

After:
User → HTTPS (port 443) → Nginx → App

---

## 🔐 TLS Certificate
A self-signed certificate was generated for local testing:

- Private key: nginx/certs/selfsigned.key
- Certificate: nginx/certs/selfsigned.crt

This is suitable for development (browser will show a warning).

---

##  Nginx Configuration (Summary)
- Listen on port 80 and redirect to HTTPS
- Listen on port 443 with SSL enabled
- Use generated certificate and key
- Proxy requests to the Flask service

Key directives:
- listen 443 ssl;
- ssl_certificate /etc/nginx/certs/selfsigned.crt;
- ssl_certificate_key /etc/nginx/certs/selfsigned.key;
- return 301 https://$host$request_uri;

---

##  Docker Compose Changes
- Expose ports 80 and 443 on Nginx
- Mount certificates directory into container

---

##  Commands Used
Start:
docker compose up -d --build

Stop:
docker compose down

Check containers:
docker ps

Logs:
docker logs nginx_proxy

---

## 📌 Result
- HTTPS endpoint available
- HTTP traffic redirected to HTTPS
- Certificates correctly loaded by Nginx

---

##  Security Notes
- Self-signed certificate is for development only
- For production, use Let's Encrypt (certbot) and auto-renewal
- Enforce strong TLS protocols and ciphers

