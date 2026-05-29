# pfSense Firewall

## Purpose

This document explains how pfSense is used in the homelab.

pfSense acts as the main firewall, router, gateway, and DHCP server for the internal LAN network.

---

## Interfaces

| Interface | Role | IP Address |
|---|---|---|
| WAN | Internet / NAT access | 192.168.127.135 |
| LAN | Internal homelab network | 10.10.10.1 |
| DMZ | Dedicated DMZ interface | 10.10.20.1 |

The LAN network is used for the main homelab systems such as DC01, CLIENT01, WEB01, and Wazuh.

The DMZ interface is configured, but the main Docker/web stack currently runs on the LAN Ubuntu server.

---

## DHCP Configuration

pfSense provides DHCP for the LAN network.

DHCP range:

```text
10.10.10.100 - 10.10.10.199
```

CLIENT01 receives its IP address from pfSense:

```text
CLIENT01 → 10.10.10.100
```

The DNS server provided to clients is:

```text
10.10.10.10
```

This points clients to DC01 for internal DNS resolution.

---

## Firewall Rules

The LAN firewall rules allow normal LAN traffic to the internet while blocking direct access from LAN to DMZ.

Important LAN rules:

| Rule | Purpose |
|---|---|
| Anti-lockout rule | Allows access to pfSense web interface |
| Block LAN to DMZ direct access | Prevents LAN clients from directly reaching the DMZ |
| Allow LAN to Internet | Allows LAN clients to access external networks |

The DMZ interface currently has no pass rules, which means incoming traffic on the DMZ interface is blocked by default until rules are added.

---

## Validation

The following items were validated:

- WAN interface is up
- LAN interface is up
- DMZ interface is up
- DHCP server is active on LAN
- CLIENT01 received a DHCP lease
- LAN firewall rules are configured
- DMZ has no allow rules by default

---

## Validation Screenshots

Related screenshots:

```text
Screenshots/01-pfsense/01-pfsense-wan-interface.png
Screenshots/01-pfsense/02-pfsense-lan-interface.png
Screenshots/01-pfsense/03-pfsense-dmz-interface.png
Screenshots/01-pfsense/04-pfsense-dhcp-lan-range.png
Screenshots/01-pfsense/05-pfsense-dhcp-lan-options.png
Screenshots/01-pfsense/06-pfsense-lan-firewall-rules.png
Screenshots/01-pfsense/07-pfsense-dmz-firewall-rules.png
Screenshots/01-pfsense/08-pfsense-dhcp-lease-client01.png
```

---

## Notes

The DMZ is configured on pfSense, but the current web stack is still hosted on the LAN server at `10.10.10.20`.

This is acceptable for the current version of the homelab because the project is focused on learning and documentation. A future improvement would be to move the vulnerable web applications and reverse proxy to a dedicated DMZ server.

---

## Future Improvements

Possible improvements:

- Move Docker web services to the DMZ
- Add stricter DMZ firewall rules
- Add specific allow rules from LAN to selected DMZ services only
- Add pfSense screenshots of NAT and aliases if used later