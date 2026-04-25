#!/usr/bin/env bash
set -euo pipefail

# Day 07 - Production-oriented UFW baseline for:
# Nginx (80/443), Dockerized Flask app (internal), Suricata, ModSecurity, Prometheus/Grafana.
#
# IMPORTANT:
# 1) Replace ADMIN_CIDR and MONITORING_CIDR before use.
# 2) Run from a console with out-of-band access (or tmux/screen) to avoid SSH lockout.
# 3) Docker can bypass UFW for published ports, so DOCKER-USER controls are included below.

ADMIN_CIDR="203.0.113.0/24"      # <-- Replace with your real admin network
MONITORING_CIDR="10.10.0.0/16"   # <-- Replace with your internal monitoring network
WAN_IF="eth0"                    # <-- Replace with your public interface (ip -br a)

# Reset UFW to avoid inheriting old/insecure rules.
sudo ufw --force reset

# Deny-by-default model (required baseline).
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Permit loopback for local processes and service health.
sudo ufw allow in on lo comment 'Allow loopback inbound traffic'
sudo ufw allow out on lo comment 'Allow loopback outbound traffic'

# Anti-spoofing: block RFC1918 sources arriving from public interface.
sudo ufw deny in on "$WAN_IF" from 10.0.0.0/8 comment 'Drop private source on WAN (spoofing control)'
sudo ufw deny in on "$WAN_IF" from 172.16.0.0/12 comment 'Drop private source on WAN (spoofing control)'
sudo ufw deny in on "$WAN_IF" from 192.168.0.0/16 comment 'Drop private source on WAN (spoofing control)'

# SSH only from admin network (strict access control).
sudo ufw allow in proto tcp from "$ADMIN_CIDR" to any port 22 comment 'SSH only from admin network'

# Public web exposure through reverse proxy only.
sudo ufw allow in proto tcp to any port 80 comment 'Public HTTP to Nginx reverse proxy'
sudo ufw allow in proto tcp to any port 443 comment 'Public HTTPS to Nginx reverse proxy'

# Explicitly deny direct access to backend app and common internal services.
sudo ufw deny in proto tcp to any port 5000 comment 'Block direct Flask access from host network'
sudo ufw deny in proto tcp to any port 3000 comment 'Block Grafana from public network'
sudo ufw deny in proto tcp to any port 9090 comment 'Block Prometheus from public network'
sudo ufw deny in proto tcp to any port 9100 comment 'Block node exporter from public network'

# Optional internal-only monitoring access (enable only if needed).
# sudo ufw allow in proto tcp from "$MONITORING_CIDR" to any port 3000 comment 'Grafana internal access only'
# sudo ufw allow in proto tcp from "$MONITORING_CIDR" to any port 9090 comment 'Prometheus internal access only'
# sudo ufw allow in proto tcp from "$MONITORING_CIDR" to any port 9100 comment 'Node exporter internal access only'

# Rate-limit SSH brute-force attempts.
sudo ufw limit in proto tcp from "$ADMIN_CIDR" to any port 22 comment 'Rate-limit SSH from admin network'

# Enable firewall and print numbered rules.
sudo ufw --force enable
sudo ufw status numbered

# -----------------------------------------------------------------------------
# Docker hardening note:
# UFW alone does NOT fully control Docker-published ports. Enforce policy in
# DOCKER-USER chain so only expected published services remain reachable.
# -----------------------------------------------------------------------------

# Accept established sessions first.
sudo iptables -I DOCKER-USER 1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Allow published web ports to containers (if Docker publishes them).
sudo iptables -I DOCKER-USER 2 -i "$WAN_IF" -p tcp --dport 80 -j ACCEPT
sudo iptables -I DOCKER-USER 3 -i "$WAN_IF" -p tcp --dport 443 -j ACCEPT

# Drop all other new inbound traffic headed to Docker-published ports.
sudo iptables -I DOCKER-USER 4 -i "$WAN_IF" -j DROP

# (Recommended) Persist iptables rules across reboot.
# sudo apt-get update && sudo apt-get install -y iptables-persistent
# sudo netfilter-persistent save
