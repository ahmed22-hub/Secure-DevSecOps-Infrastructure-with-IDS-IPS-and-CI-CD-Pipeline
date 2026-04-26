#  Day 12 — Docker Network Segmentation

##  Objective
Separate public access from internal services to improve security.

---

##  Concept

Before:
User → Nginx → Flask (same network)

After:
User → Public Network → Nginx → Internal Network → Flask

---

##  What was done

Two networks were created:

- public-network (accessible)
- internal-network (private)

---

##  Docker Compose

services:
  web:
    build: ../app
    container_name: flask_app
    expose:
      - "5000"
    networks:
      - internal-network

  nginx:
    image: nginx:latest
    container_name: nginx_proxy
    ports:
      - "80:80"
    networks:
      - public-network
      - internal-network

networks:
  public-network:
  internal-network:

---

##  Explanation

- Flask is hidden (internal only)
- Nginx is public
- Nginx connects both networks

---

## ⚙️ Commands

docker compose up -d --build
docker ps
docker network ls
docker compose down

---

##  Tests

✔ http://localhost → works  
❌ http://localhost:5000 → blocked  

---

##  Architecture

Internet
   |
   v
[ public-network ]
   |
 Nginx
   |
[ internal-network ]
   |
 Flask

---

##  Result

- App is protected
- Nginx is entry point
- Internal network is isolated

---

##  Importance

First real security layer before WAF and IDS.
