# day9 — Docker Compose Setup

## objective

The goal of this step is to orchestrate the application using Docker Compose, so we can manage services easily with a single command.

---

## What is Docker Compose?

Docker Compose is a tool that allows us to define and run multiple containers using one configuration file.

Instead of running multiple Docker commands manually, we use:

docker compose up -d

---

## project Structure

project/
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── docker/
│   └── docker-compose.yml

---

## docker-compose.yml

services:
  web:
    build: ../app
    container_name: flask_app
    ports:
      - "5000:5000"
    environment:
      - PORT=5000
      - DEBUG=True
      - ADMIN_USERNAME=admin
      - ADMIN_PASSWORD=admin
    networks:
      - app-network

networks:
  app-network:

---

## Commands Used

Start services:
docker compose up -d

Verify:
docker ps

Logs:
docker logs flask_app

Stop:
docker compose down

Rebuild:
docker compose up --build

---

## lifecycle Summary

- Lancer: docker compose up -d
- Verifier: docker ps
- Logs: docker logs
- Stop: docker compose down
- Rebuild: docker compose up --build

---


## result

Application runs using Docker Compose  
Environment variables applied  
Container managed easily  

