# Cybersecurity & Networking Homelab

This is a personal cybersecurity and networking homelab built as a student project.

The goal of this project was to practice real IT infrastructure skills such as networking, Windows Server, Linux administration, Docker, reverse proxy configuration, monitoring, VPN access, and basic SIEM/log analysis.

This project is not meant to be a perfect enterprise production environment. It is a learning lab used to understand how different infrastructure and security components work together.

---

## Project Summary

The homelab includes:

- pfSense firewall and routing
- LAN and DMZ interfaces
- Windows Server Active Directory domain
- Internal DNS
- DHCP provided by pfSense
- Windows client joined to the domain
- Ubuntu server hosting Docker services
- nginx reverse proxy
- HTTPS using a local certificate authority
- Grafana and Prometheus monitoring
- Uptime Kuma service monitoring
- Portainer container management
- Wazuh SIEM with Windows and Linux agents
- nginx log collection in Wazuh
- UFW firewall hardening
- fail2ban protection
- WireGuard VPN
- Basic admin and recovery scripts

---

## Network Overview

| System | Role | IP Address |
|---|---|---|
| pfSense | Firewall / Gateway | 10.10.10.1 |
| DC01 | Active Directory / DNS | 10.10.10.10 |
| WEB01 / Ubuntu Server | nginx, Docker, monitoring tools | 10.10.10.20 |
| Wazuh Server | SIEM Manager / Dashboard | 10.10.10.30 |
| CLIENT01 | Windows domain client | 10.10.10.100 |
| WireGuard Server | VPN interface | 10.200.200.1 |
| WireGuard Client | VPN client | 10.200.200.2 |

Domain:

```text
homelab.local
```

---

## Services

| Service | URL |
|---|---|
| Grafana | https://grafana.homelab.local |
| Prometheus | https://prometheus.homelab.local |
| Uptime Kuma | https://status.homelab.local |
| Portainer | https://portainer.homelab.local |
| Wazuh | https://wazuh.homelab.local |
| DVWA | https://dvwa.homelab.local |
| Juice Shop | https://juice.homelab.local |

Docker services are bound to `127.0.0.1` and exposed through nginx reverse proxy instead of being directly exposed to the LAN.

---

## What I Practiced

This project helped me practice:

- VMware virtualization
- pfSense interface and firewall configuration
- LAN / DMZ network design
- Windows Server 2022
- Active Directory domain setup
- DNS configuration
- DHCP configuration with pfSense
- Windows client domain join
- Ubuntu Server administration
- Docker container deployment
- nginx reverse proxy configuration
- Local HTTPS certificates
- Prometheus and Grafana monitoring
- Uptime Kuma health checks
- Portainer container management
- Wazuh SIEM basics
- Log collection from nginx
- Linux firewall hardening with UFW
- fail2ban jails for SSH and nginx
- WireGuard VPN setup
- Bash scripting for checks and recovery
- GitHub project documentation

---

## Security Features

Some security features implemented in the lab:

- pfSense firewall rules
- DMZ interface configured
- UFW enabled on Ubuntu
- Default deny incoming firewall policy
- fail2ban enabled for SSH and nginx
- nginx security headers
- nginx server tokens disabled
- HTTPS reverse proxy
- Docker apps exposed only on localhost
- Wazuh agents connected
- nginx logs collected by Wazuh
- WireGuard VPN tunnel

---

## Monitoring

Monitoring was implemented with:

- Prometheus
- Node Exporter
- Grafana
- Uptime Kuma
- Portainer

The monitoring stack is used to check host metrics, container status, and service availability.

---

## Wazuh SIEM

Wazuh was deployed to practice basic SIEM concepts.

Current Wazuh setup includes:

- Wazuh server
- Wazuh dashboard
- Wazuh agents on Windows and Linux systems
- Active agents visible in the dashboard
- nginx access and error log collection
- security events visible in Threat Hunting

---

## Scripts

The `Scripts/` folder contains simple administration scripts:

| Script | Purpose |
|---|---|
| `security-audit.sh` | Shows system, network, Docker, nginx, fail2ban, WireGuard and port status |
| `web-healthcheck.sh` | Tests the main web services through HTTPS |
| `homelab-recover.sh` | Restarts important services after reboot or issues |

---

## Screenshots

Screenshots are stored in the `Screenshots/` folder.

Main categories:

```text
Screenshots/
├── 01-pfsense/
├── 02-active-directory/
├── 03-client-domain/
├── 04-ubuntu-server/
├── 05-nginx-reverse-proxy/
├── 06-docker-stack/
├── 07-monitoring/
├── 08-wazuh-siem/
├── 09-security-hardening/
├── 10-wireguard-vpn/
└── 11-scripts/
```

---

## Current Limitations

Some parts of the lab could be improved in a future version:

- The DMZ interface exists, but the main Docker/web stack currently runs on the LAN Ubuntu server.
- The VPN was tested inside the lab network, but not yet from a fully external network.
- Wazuh detections are basic and can be improved with more custom rules.
- More automation could be added later with Ansible or backup scripts.

---

## Future Improvements

Possible next steps:

- Move the web/Docker stack to a dedicated DMZ server
- Add more Wazuh custom detection rules
- Add more MITRE ATT&CK mapping
- Improve the network diagram
- Add automated backups
- Add Suricata or another IDS
- Add more detailed documentation for each component

---

## Note

This is a student homelab project built for learning and portfolio purposes.

The goal was to build something practical, document the process, and show hands-on experience with networking, system administration, monitoring, and cybersecurity tools.