# Docker Stack

## Purpose

This document explains the Docker stack used on the Ubuntu server.

The goal was to run multiple web, monitoring, and management services in containers while keeping them isolated from direct LAN access.

---

## Host

Docker runs on the Ubuntu server:

| Host | Role | IP Address |
|---|---|---|
| WEB01 / Ubuntu Server | Docker host | 10.10.10.20 |

---

## Containers

The Docker stack includes:

| Container | Purpose | Local Binding |
|---|---|---|
| `grafana` | Monitoring dashboard | 127.0.0.1:3000 |
| `prometheus` | Metrics collection | 127.0.0.1:9090 |
| `uptime-kuma` | Service monitoring | 127.0.0.1:3001 |
| `portainer` | Docker management | 127.0.0.1:9000 / 127.0.0.1:9443 |
| `dvwa` | Vulnerable web application | 127.0.0.1:8080 |
| `juice-shop` | Vulnerable web application | 127.0.0.1:3002 |
| `node-exporter` | Host metrics exporter | 9100/tcp |

---

## Localhost Binding

Most Docker services are bound to `127.0.0.1`.

This means they are not directly exposed to the LAN.

External access is handled through nginx reverse proxy.

Example:

```text
https://grafana.homelab.local → nginx → 127.0.0.1:3000
https://dvwa.homelab.local → nginx → 127.0.0.1:8080
```

This helps reduce direct exposure of container ports.

---

## Monitoring Network

Grafana and Prometheus were connected through a Docker network so Grafana could query Prometheus using:

```text
http://prometheus:9090
```

Prometheus collects metrics from Node Exporter on:

```text
10.10.10.20:9100
```

---

## Validation

Docker was validated with:

```bash
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

Listening ports were validated with:

```bash
sudo ss -tulpn
```

The validation confirmed:

- containers are running
- Uptime Kuma is healthy
- web application containers are bound to localhost
- nginx exposes services through HTTPS reverse proxy
- Node Exporter listens on port 9100

---

## Validation Screenshots

Related screenshots:

```text
Screenshots/06-docker-stack/01-docker-containers-localhost-bindings.png
Screenshots/06-docker-stack/02-listening-ports.png
Screenshots/07-monitoring/04-portainer-containers.png
```

---

## Notes

The Docker applications are intentionally not exposed directly on the LAN.

This design keeps nginx as the main entry point for web services.

---

## Future Improvements

Possible improvements:

- Move Docker web services to a dedicated DMZ server
- Use Docker Compose files for easier redeployment
- Add container backup documentation
- Add healthchecks for all containers
- Add more network separation between services