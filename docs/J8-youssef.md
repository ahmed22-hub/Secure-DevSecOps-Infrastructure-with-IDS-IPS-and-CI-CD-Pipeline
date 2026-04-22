# 📅 Jour 8 — Docker

## 🎯 Objectif
Dockeriser l’application

## 📄 Dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "app.py"]

## ⚙️ Commandes
docker build -t my-flask-app .
docker run -p 5000:5000 -e PORT=5000 -e ADMIN_USERNAME=admin -e ADMIN_PASSWORD=admin my-flask-app

## 📌 Résultat
Application fonctionne dans Docker
