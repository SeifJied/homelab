# WireGuard VPN

## Purpose

This document explains the WireGuard VPN setup used in the homelab.

The goal was to practice VPN configuration and create an encrypted tunnel between a client and the Ubuntu server.

---

## VPN Network

WireGuard uses the following VPN subnet:

```text
10.200.200.0/24
```

| Component | VPN IP |
|---|---|
| WireGuard Server | 10.200.200.1 |
| WireGuard Client | 10.200.200.2 |

The WireGuard server runs on the Ubuntu server:

| Host | LAN IP | VPN IP |
|---|---|---|
| WEB01 / Ubuntu Server | 10.10.10.20 | 10.200.200.1 |

---

## Port

WireGuard listens on:

```text
51820/udp
```

This port is allowed through UFW.

---

## Client

The Windows client has a WireGuard tunnel interface with:

```text
10.200.200.2
```

The client also uses the internal DNS server:

```text
10.10.10.10
```

---

## Validation

WireGuard was validated using:

```bash
sudo wg show
```

The validation confirmed:

- interface `wg0` is active
- WireGuard listens on port `51820`
- the client peer is configured
- latest handshake is recent
- RX/TX traffic is increasing
- the client uses `10.200.200.2/32`

---

## Validation Screenshots

Related screenshots:

```text
Screenshots/10-wireguard-vpn/01-wireguard-server-handshake.png
Screenshots/03-client-domain/01-client01-ipconfig-domain.png
```

---

## Notes

The VPN was validated inside the homelab network.

This confirms that the tunnel, handshake, and traffic transfer work, but a future improvement would be to test WireGuard from a fully external network.

---

## Future Improvements

Possible improvements:

- Test the VPN from an external remote client
- Add a dedicated remote client VM
- Add pfSense WAN port forwarding for remote VPN access
- Document the WireGuard client configuration
- Add more strict VPN firewall rules