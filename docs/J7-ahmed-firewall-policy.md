# Day 07 — Firewall Policy Review (Pre-Implementation)

## Scope reviewed
Architecture in this repository:
- Nginx reverse proxy (public entrypoint)
- Flask app in Docker (must stay internal)
- ModSecurity WAF (at Nginx layer)
- Suricata IDS/IPS
- Prometheus + Grafana monitoring

---

## 1) Improved firewall policy (production baseline)

### Security objectives
1. **Deny by default** for inbound traffic.
2. Expose only required public services: **80/443**.
3. Restrict administrative access: **22/tcp only from admin CIDR**.
4. Keep application and monitoring ports internal (not public).
5. Prevent Docker from unintentionally bypassing host firewall intent.

### Policy table

| Rule ID | Direction | Source | Destination/Port | Action | Rationale |
|---|---|---|---|---|---|
| FW-01 | Inbound | Any | Any | Deny (default) | Zero-trust baseline for unsolicited traffic |
| FW-02 | Outbound | Host | Any | Allow (default) | Keeps OS/package updates operational (can be tightened later) |
| FW-03 | Inbound | Loopback | Loopback | Allow | Required for local IPC and health paths |
| FW-04 | Inbound | Admin CIDR | 22/tcp | Allow + rate limit | SSH only from trusted network |
| FW-05 | Inbound | Public | 80/tcp | Allow | Public HTTP to Nginx |
| FW-06 | Inbound | Public | 443/tcp | Allow | Public HTTPS to Nginx |
| FW-07 | Inbound | Public | 5000/tcp | Deny | Block direct Flask access |
| FW-08 | Inbound | Public | 3000,9090,9100/tcp | Deny | Block public monitoring exposure |
| FW-09 | Inbound | RFC1918 over WAN | Any | Deny | Anti-spoofing control on external interface |
| FW-10 | Forward (Docker) | Public | Docker published ports | Allow only 80/443, drop rest | Prevent Docker port exposure drift |

---

## 2) Missing security rules / hardening additions

1. **DOCKER-USER enforcement**: Docker NAT can bypass expected UFW behavior for published ports. Add explicit allowlist/drop in `DOCKER-USER`.
2. **SSH brute-force resistance**: add `ufw limit 22/tcp` and prefer key-based auth + disable password auth in sshd.
3. **Monitoring segregation**: if Grafana/Prometheus are host-published, restrict to monitoring/admin CIDRs only.
4. **Anti-spoofing on WAN**: deny RFC1918 source ranges arriving on internet-facing interface.
5. **Auditability**: keep `comment` tags on each UFW rule for operational clarity.
6. **Port drift detection**: regularly compare `docker ps --format '{{.Ports}}'` with firewall policy.

---

## 3) Risk review (Docker, exposed ports, monitoring)

### Docker-related risks
- `docker run -p` or compose `ports:` can expose internal services unintentionally.
- UFW alone is not always sufficient to enforce intent on DNAT paths.
- Risk level: **High** (common misconfiguration pattern).

### Exposed ports risks
- Exposing Flask app (`5000`) bypasses reverse proxy/WAF controls.
- Exposing Grafana (`3000`) or Prometheus (`9090`) publicly can leak infrastructure intelligence.
- Risk level: **High** for public exposure, **Medium** for internal-only with weak auth.

### Monitoring risks
- Prometheus targets may expose metadata and service topology.
- Grafana admin weak credentials is frequently exploited.
- Recommendation: internal-only access + SSO/strong auth + least-privilege dashboards.

---

## 4) UFW configuration (ready-to-apply)

Use script:

```bash
bash infra/firewall/ufw_day07_policy.sh
```

Or apply manually (replace placeholders first):

```bash
# Variables (replace)
ADMIN_CIDR="203.0.113.0/24"
WAN_IF="eth0"

sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow in on lo comment 'Allow loopback inbound traffic'
sudo ufw allow out on lo comment 'Allow loopback outbound traffic'

sudo ufw deny in on "$WAN_IF" from 10.0.0.0/8 comment 'Drop private source on WAN (spoofing control)'
sudo ufw deny in on "$WAN_IF" from 172.16.0.0/12 comment 'Drop private source on WAN (spoofing control)'
sudo ufw deny in on "$WAN_IF" from 192.168.0.0/16 comment 'Drop private source on WAN (spoofing control)'

sudo ufw allow in proto tcp from "$ADMIN_CIDR" to any port 22 comment 'SSH only from admin network'
sudo ufw limit in proto tcp from "$ADMIN_CIDR" to any port 22 comment 'Rate-limit SSH from admin network'

sudo ufw allow in proto tcp to any port 80 comment 'Public HTTP to Nginx reverse proxy'
sudo ufw allow in proto tcp to any port 443 comment 'Public HTTPS to Nginx reverse proxy'

sudo ufw deny in proto tcp to any port 5000 comment 'Block direct Flask access from host network'
sudo ufw deny in proto tcp to any port 3000 comment 'Block Grafana from public network'
sudo ufw deny in proto tcp to any port 9090 comment 'Block Prometheus from public network'
sudo ufw deny in proto tcp to any port 9100 comment 'Block node exporter from public network'

sudo ufw --force enable
sudo ufw status numbered
```

Docker enforcement (important):

```bash
sudo iptables -I DOCKER-USER 1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -I DOCKER-USER 2 -i "$WAN_IF" -p tcp --dport 80 -j ACCEPT
sudo iptables -I DOCKER-USER 3 -i "$WAN_IF" -p tcp --dport 443 -j ACCEPT
sudo iptables -I DOCKER-USER 4 -i "$WAN_IF" -j DROP
```

---

## 5) Operational notes before implementation

1. Validate with out-of-band console access before enabling UFW on remote VM.
2. Confirm no accidental compose `ports:` for internal services except Nginx.
3. If moving to strict egress control later, allow DNS/NTP/apt explicitly before `default deny outgoing`.
4. Add Suricata inline policy only after firewall baseline is stable to avoid troubleshooting ambiguity.
