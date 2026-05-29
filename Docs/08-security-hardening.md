# Security Hardening

## Purpose

This document explains the basic security hardening applied to the Ubuntu server and web stack.

The goal was to reduce unnecessary exposure, control inbound traffic, and add basic protection against brute-force and abusive web requests.

---

## UFW Firewall

UFW is enabled on the Ubuntu server.

Default policy:

```text
deny incoming
allow outgoing
deny routed
```

Allowed services include:

| Port | Service | Purpose |
|---|---|---|
| 22/tcp | SSH | Remote administration |
| 80/tcp | nginx HTTP | Web reverse proxy |
| 443/tcp | nginx HTTPS | Secure reverse proxy |
| 51820/udp | WireGuard | VPN tunnel |
| 9100/tcp | Node Exporter | Prometheus metrics |

Port `9100/tcp` is allowed only from:

```text
10.10.10.0/24
172.17.0.0/16
```

This allows LAN access and Prometheus Docker access to Node Exporter.

---

## fail2ban

fail2ban is enabled to protect SSH and nginx.

Configured jails:

- sshd
- nginx-botsearch
- nginx-http-auth
- nginx-limit-req

The `nginx-limit-req` jail detected events and performed bans during testing.

---

## nginx Hardening

nginx was hardened with:

- HTTPS reverse proxy
- security headers
- rate limiting
- server tokens disabled

The HTTP header was validated to show:

```text
Server: nginx
```

Instead of exposing the full nginx version.

---

## Docker Exposure

Docker web applications are bound to:

```text
127.0.0.1
```

This means the containers are not directly exposed to the LAN.

Access is handled through nginx reverse proxy.

---

## Validation

Security hardening was validated with:

```bash
sudo ufw status verbose
sudo fail2ban-client status
sudo fail2ban-client status sshd
sudo fail2ban-client status nginx-limit-req
curl -I http://localhost
sudo ss -tulpn
```

The validation confirmed:

- UFW is active
- default incoming traffic is denied
- required services are allowed
- fail2ban jails are active
- nginx-limit-req detected events
- Docker apps are bound to localhost
- nginx does not expose its version

---

## Validation Screenshots

Related screenshots:

```text
Screenshots/09-security-hardening/01-ufw-status.png
Screenshots/09-security-hardening/02-fail2ban-jails.png
Screenshots/05-nginx-reverse-proxy/04-nginx-server-tokens-off.png
Screenshots/06-docker-stack/02-listening-ports.png
```

---

## Notes

This hardening is basic and appropriate for a learning homelab.

It does not replace a complete production security baseline, but it demonstrates practical security controls such as firewall rules, log-based blocking, and reduced service exposure.

---

## Future Improvements

Possible improvements:

- Add more specific nginx rate limiting rules
- Add more fail2ban jails
- Add log rotation documentation
- Add vulnerability scanning reports
- Add host hardening checklist
- Add automated security audits