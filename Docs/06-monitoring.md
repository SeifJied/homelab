# Monitoring

## Purpose

This document explains the monitoring tools used in the homelab.

The goal was to monitor system metrics, service availability, and Docker containers using simple open-source tools.

---

## Monitoring Tools

The monitoring stack includes:

| Tool | Purpose |
|---|---|
| Prometheus | Collects metrics |
| Node Exporter | Exposes Ubuntu host metrics |
| Grafana | Displays metrics dashboards |
| Uptime Kuma | Monitors service availability |
| Portainer | Manages and views Docker containers |

---

## Prometheus

Prometheus collects metrics from the Ubuntu server using Node Exporter.

The monitored target is:

```text
ubuntu-srv01.homelab.local
10.10.10.20:9100
```

Prometheus confirmed the target as:

```text
State: UP
```

---

## Grafana

Grafana is used to display system metrics from Prometheus.

The Node Exporter dashboard shows information such as:

- CPU usage
- system load
- RAM usage
- swap usage
- filesystem usage
- system uptime
- network traffic

Grafana connects to Prometheus using:

```text
http://prometheus:9090
```

---

## Uptime Kuma

Uptime Kuma is used to monitor service availability.

The monitored services include:

- Uptime Kuma
- Portainer
- Homelab Web Server
- Ubuntu SSH
- DC01

The final validation showed all monitored services as UP.

---

## Portainer

Portainer is used to view and manage Docker containers.

It shows the main homelab containers running, including:

- dvwa
- grafana
- juice-shop
- node-exporter
- portainer
- prometheus
- uptime-kuma

---

## Validation

Monitoring was validated by checking:

- Prometheus target status
- Grafana dashboard metrics
- Uptime Kuma service status
- Portainer container list

---

## Validation Screenshots

Related screenshots:

```text
Screenshots/07-monitoring/01-grafana-node-exporter-dashboard.png
Screenshots/07-monitoring/02-prometheus-targets-up.png
Screenshots/07-monitoring/03-uptime-kuma-services.png
Screenshots/07-monitoring/04-portainer-containers.png
```

---

## Notes

Prometheus initially could not reach Node Exporter because UFW only allowed port `9100/tcp` from the LAN subnet.

A rule was added to allow Prometheus from the Docker network:

```text
172.17.0.0/16 → 9100/tcp
```

After this, the Prometheus target became UP and Grafana dashboards displayed metrics correctly.

---

## Future Improvements

Possible improvements:

- Add more Grafana dashboards
- Add alerting rules in Prometheus
- Add email or Discord notifications
- Monitor more hosts
- Add long-term metrics storage