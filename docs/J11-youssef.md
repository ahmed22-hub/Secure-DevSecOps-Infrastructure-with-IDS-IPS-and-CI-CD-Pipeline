#  Day 11 — Nginx Reverse Proxy Setup

##  Objective

The goal of this step is to introduce a clear entry point in front of the application using Nginx.

Instead of accessing the application directly, all traffic goes through Nginx.

---

##  Architecture

Before:
User → Flask App (direct access)

After:
User → Nginx → Flask App

---

##  What is Nginx?

Nginx is a web server and reverse proxy.

It receives client requests and forwards them to the backend application.

---

##  Nginx Configuration

server {
    listen 80;

    location / {
        proxy_pass http://web:5000;
    }

    error_page 500 502 503 504 /error.html;
}

---

##  Explanation

- listen 80 → Nginx listens on port 80
- location / → applies to all requests
- proxy_pass → forwards requests to the Flask service
- web → service name in docker-compose

---

##  Docker Compose Integration

We added a new service:

- nginx (reverse proxy)
- web (Flask app)

Flask is no longer exposed publicly.

---

##  Commands Used

Start services:
docker compose up -d --build

Check containers:
docker ps

Check logs:
docker logs nginx_proxy

Stop:
docker compose down

---

##  Verification

- Access via http://localhost → OK
- Requests go through Nginx
- Application responds correctly
- Logs show incoming requests

---

##  Logs

Nginx logs allow us to:
- monitor traffic
- detect anomalies
- debug issues

---

##  Result

✔ Nginx acts as entry point  
✔ Flask app is hidden behind proxy  
✔ System ready for security layers  

---

##  Team Note

The following information is important for the security layer integration:

- Entry point: http://localhost
- Reverse proxy: Nginx
- Logs available via: nginx_proxy container
- Application is accessible only through Nginx

This setup allows future integration of WAF and IDS components.

---

## 🚀 Why this step is important?

- Enables traffic control
- Prepares WAF integration
- Improves security architecture
- Standard practice in DevOps
