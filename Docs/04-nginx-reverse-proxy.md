# nginx Reverse Proxy

## Purpose

This document explains how nginx is used as a reverse proxy in the homelab.

The goal was to expose multiple internal web services using clean internal domain names and HTTPS, while keeping Docker containers bound to localhost.

---

## Reverse Proxy Design

nginx runs on the Ubuntu server:

| Host | Role | IP Address |
|---|---|---|
| WEB01 / Ubuntu Server | nginx reverse proxy | 10.10.10.20 |

nginx listens on:

```text
80/tcp
443/tcp
```

The Docker applications are not exposed directly to the LAN.  
They are bound to `127.0.0.1` and accessed through nginx.

---

## Internal URLs

| Service | Internal URL | Backend |
|---|---|---|
| Grafana | https://grafana.homelab.local | 127.0.0.1:3000 |
| Prometheus | https://prometheus.homelab.local | 127.0.0.1:9090 |
| Uptime Kuma | https://status.homelab.local | 127.0.0.1:3001 |
| Portainer | https://portainer.homelab.local | 127.0.0.1:9443 |
| DVWA | https://dvwa.homelab.local | 127.0.0.1:8080 |
| Juice Shop | https://juice.homelab.local | 127.0.0.1:3002 |
| Wazuh | https://wazuh.homelab.local | 10.10.10.30 |

---

## HTTPS

HTTPS was configured using a local certificate authority.

The certificate is used by nginx for the internal `homelab.local` services.

This allowed internal services to be accessed through HTTPS instead of plain HTTP.

---

## Security Hardening

Basic nginx hardening was applied:

- HTTPS reverse proxy
- security headers
- server tokens disabled
- rate limiting for selected paths
- Docker services exposed only through nginx

The nginx version is hidden from HTTP headers.

Expected result:

```text
Server: nginx
```

Instead of exposing the full nginx version.

---

## Validation

nginx was validated with:

```bash
sudo systemctl status nginx --no-pager
sudo nginx -t
ls -la /etc/nginx/sites-enabled/
```

HTTPS reverse proxy tests were validated with:

```bash
curl -k -s -o /dev/null -w "Grafana: %{http_code}\n" https://grafana.homelab.local
curl -k -s -o /dev/null -w "Wazuh: %{http_code}\n" https://wazuh.homelab.local
curl -k -s -o /dev/null -w "DVWA: %{http_code}\n" https://dvwa.homelab.local
curl -k -s -o /dev/null -w "Juice Shop: %{http_code}\n" https://juice.homelab.local
```

The services returned valid HTTP status codes such as `200` and `302`.

---

## Validation Screenshots

Related screenshots:

```text
Screenshots/05-nginx-reverse-proxy/01-nginx-status-config-test.png
Screenshots/05-nginx-reverse-proxy/02-nginx-sites-enabled.png
Screenshots/05-nginx-reverse-proxy/03-nginx-reverse-proxy-http-status-tests.png
Screenshots/05-nginx-reverse-proxy/04-nginx-server-tokens-off.png
```

---

## Notes

Prometheus may return different HTTP status codes depending on the HTTP method used.

For example, a `HEAD` request can return `405 Method Not Allowed`, while a normal `GET` request works correctly.

For this reason, service validation was done using HTTP status code checks with normal requests.

---

## Future Improvements

Possible improvements:

- Add more detailed nginx configuration examples
- Add stricter security headers
- Add separate reverse proxy rules for the DMZ in a future version
- Add automated nginx config backup
- Add more rate limiting rules