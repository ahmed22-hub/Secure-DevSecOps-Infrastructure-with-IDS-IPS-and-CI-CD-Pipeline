# Security Scope - Day 1

## 1. Introduction

This document defines the security scope of the project.
The goal is to identify critical assets, entry points, data flows, and basic security assumptions.

## 2. System Components (Assets)

The infrastructure includes the following components:

- Web Application (Flask / Node.js)
- Nginx (Reverse Proxy)
- WAF (ModSecurity)
- Firewall (UFW / iptables)
- IDS/IPS (Suricata)
- Docker Host (containers runtime)
- Monitoring (Prometheus, Grafana)
- Logging System (Wazuh / ELK Stack)
- CI/CD Pipeline (GitHub Actions)

## 3. Critical Assets

The most important assets to protect are:

- Application data (user inputs, requests, responses)
- Server access (SSH, system control)
- Logs (security events, access logs)
- CI/CD pipeline (code integrity and deployment)
- Docker environment (containers and images)

## 4. Entry Points (Attack Surface)

Possible entry points for attackers:

- HTTP / HTTPS (ports 80 / 443)
- SSH (port 22)
- Web application endpoints (/login, /api)
- CI/CD pipeline access (GitHub)

## 5. Users and Roles

- Normal User → accesses the web application
- Admin → manages server via SSH
- Developer → pushes code to GitHub

## 6. Data Flow

- The user sends a request عبر browser
- Request goes to Nginx (reverse proxy)
- Nginx forwards traffic to the web application (Docker container)
- Application processes the request
- Response is sent back to the user
- Logs are generated and stored
- Monitoring tools collect metrics

## 7. Security Layers

- Nginx → entry point
- WAF (ModSecurity) → filters malicious HTTP requests
- Firewall (UFW) → controls network traffic
- IDS/IPS (Suricata) → detects attacks
- Docker → isolates application

## 8. Security Assumptions

- Only Nginx is exposed to the internet
- Internal services are not publicly accessible
- Firewall blocks unnecessary ports
- Logs are centralized
- Monitoring is active

## 9. Basic Architecture (Text Diagram)

```text
User (Internet)
↓
Nginx (Reverse Proxy)
↓
WAF (ModSecurity)
↓
Firewall (UFW)
↓
IDS/IPS (Suricata)
↓
Docker Host
↓
Web Application
↓
Logs / Monitoring
```

## 10. Conclusion

This document provides a clear view of:

- What needs to be protected
- Where attacks can happen
- How data flows inside the system

This will help in implementing security controls in the next phases.
