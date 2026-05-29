# Automation Scripts

## Purpose

This document explains the basic scripts used to manage and validate the homelab.

The goal was to create simple Bash scripts to check services, verify security status, and recover the lab after a reboot or service issue.

---

## Scripts

The scripts are stored in:

```text
Scripts/
```

The main scripts are:

| Script | Purpose |
|---|---|
| `security-audit.sh` | Displays system, network, Docker, nginx, fail2ban, WireGuard and port status |
| `web-healthcheck.sh` | Tests the main HTTPS web services |
| `homelab-recover.sh` | Restarts important services and checks status after recovery |

---

## security-audit.sh

This script displays important system and security information.

It checks:

- hostname and OS information
- IP addresses
- routing table
- DNS configuration
- Docker containers
- nginx service status
- nginx configuration test
- fail2ban status
- WireGuard status
- listening ports

This script is useful for quickly checking if the homelab is running correctly.

---

## web-healthcheck.sh

This script tests the main web services through HTTPS.

Services tested include:

- Grafana
- Uptime Kuma
- Portainer
- Prometheus
- DVWA
- Juice Shop
- Wazuh

The script returns HTTP status codes such as:

```text
200
302
```

These codes confirm that the services are reachable through nginx reverse proxy.

---

## homelab-recover.sh

This script is used to recover the lab after a reboot, shutdown, or service issue.

It restarts:

- Docker
- nginx
- Wazuh agent
- WireGuard

It also displays:

- running Docker containers
- nginx configuration test
- fail2ban status
- WireGuard status

---

## Validation

The scripts were tested on the Ubuntu server.

Validation confirmed:

- web services respond through HTTPS
- Docker containers are running
- nginx is active
- nginx configuration is valid
- fail2ban jails are loaded
- WireGuard has an active peer and handshake
- listening ports are visible

---

## Validation Screenshots

Related screenshots:

```text
Screenshots/11-scripts/01-web-healthcheck-script.png
Screenshots/11-scripts/02-security-audit-host-info.png
Screenshots/11-scripts/03-security-audit-docker-containers.png
Screenshots/11-scripts/04-security-audit-services-status.png
Screenshots/11-scripts/05-security-audit-listening-ports.png
```

---

## Notes

These scripts are simple and were written for learning and lab administration.

They are not meant to replace professional automation tools, but they are useful for quickly validating the homelab state.

---

## Future Improvements

Possible improvements:

- Add better error handling
- Add color output for pass/fail checks
- Add automatic log export
- Add service restart checks
- Add backup automation
- Convert some checks into Ansible playbooks later