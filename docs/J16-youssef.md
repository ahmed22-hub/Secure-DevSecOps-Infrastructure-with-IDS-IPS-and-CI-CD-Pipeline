# Jour 16 — Firewall Impact Verification

## Objective

The objective of this phase is to verify the impact of firewall rules on the infrastructure services before enabling UFW rules on the security gateway.

This step helps prevent service interruption and ensures that the required network flows remain accessible after firewall activation.

---

# Infrastructure Overview

Current infrastructure:

User → VM-A1 (Nginx + Firewall) → VM-Y1 (Dockerized Flask Application)

The reverse proxy (Nginx) is the public entry point of the infrastructure.

The Flask application runs internally behind Nginx.

---

# Required Network Flows

## Public Services

The following ports must remain accessible:

| Port | Service | Purpose |
|------|----------|----------|
| 80 | HTTP | Web access |
| 443 | HTTPS | Secure web access |
| 22 | SSH | Administration and remote access |

---

## Internal Services

The following services must remain internal only:

| Port | Service | Access |
|------|----------|--------|
| 5000 | Flask Application | Internal only |

The Flask application should not be directly exposed to external users.

Access must pass through the Nginx reverse proxy.

---

# Firewall Recommendations

Important rules communicated to the cybersecurity team:

- Do not block ports 80, 443, and 22.
- Keep port 5000 internal only.
- Only Nginx should be publicly accessible.



# Verification Tests

## Check exposed ports

```bash
sudo ss -tuln
```

## Verify web access

```bash
curl http://localhost
```

## Verify internal application access

```bash
curl http://localhost:5000
```

---

# Expected Result

- Nginx remains accessible from users.
- Flask application stays protected internally.
- SSH administration remains available.
- Firewall rules do not break the infrastructure.

---

# Communication With Ahmed

The final list of critical ports and required network flows was shared with Ahmed before applying firewall rules.

This ensures that the infrastructure remains operational after enabling UFW protection.
