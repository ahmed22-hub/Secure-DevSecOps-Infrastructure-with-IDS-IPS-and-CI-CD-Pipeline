#  Day 13 — Logs and Healthchecks

##  Objective

The goal of this step is to improve system visibility and debugging.

We want to easily know:
- if the application is running
- what is happening inside the system
- where errors occur

---

##  Concept

Two main elements were added:

- Healthcheck → to monitor application status
- Logs → to track requests and errors

---

##  Healthcheck (Docker)

A healthcheck was added to the Flask service.

It periodically checks if the application is alive using:

curl http://localhost:5000/health

### Configuration:

healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:5000/health"]
  interval: 10s
  timeout: 5s
  retries: 3

### Explanation:

- test → command used to verify app status
- interval → runs every 10 seconds
- timeout → fails if no response in 5 seconds
- retries → marked unhealthy after 3 failures

---

##  Nginx Logs

Logs were enabled in nginx configuration:

access_log /var/log/nginx/access.log;
error_log /var/log/nginx/error.log;

### Purpose:

- access_log → records incoming requests
- error_log → records system errors

---

##  Commands Used

Start services:
docker compose up -d --build

Check containers:
docker ps

Check logs:
docker logs flask_app
docker logs nginx_proxy

Stop services:
docker compose down

---

##  Verification

✔ Access application:
http://localhost → OK

✔ Healthcheck endpoint:
http://localhost/health → OK

✔ Logs show normal requests

---

##  Failure Test

Stop Flask container:
docker stop flask_app

Result:
- healthcheck fails
- container becomes unhealthy or stops

---

##  Result

- System status is visible
- Errors can be detected quickly
- Debugging is easier

---

##  Importance

This step prepares the infrastructure for:
- monitoring tools
- alert systems
- security analysis

Logs and healthchecks are essential for DevSecOps.
