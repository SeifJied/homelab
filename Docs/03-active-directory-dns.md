# Active Directory and DNS

## Purpose

This document explains the Windows Server Active Directory and DNS configuration used in the homelab.

The goal was to create a basic Windows domain environment with a domain controller, internal DNS, and a Windows client joined to the domain.

---

## Domain Information

| Item | Value |
|---|---|
| Domain | homelab.local |
| Domain Controller | DC01 |
| DC01 IP Address | 10.10.10.10 |
| Client | CLIENT01 |
| Client IP Address | 10.10.10.100 |
| DNS Server | 10.10.10.10 |
| DHCP Server | pfSense / 10.10.10.1 |

DC01 is responsible for Active Directory and internal DNS.

pfSense provides DHCP, but clients receive `10.10.10.10` as their DNS server.

---

## Active Directory Setup

The Windows Server was promoted to a domain controller for the domain:

```text
homelab.local
```

Organizational Units were created to organize users, computers, and servers.

Main OUs include:

- Admins
- Groups
- Servers
- Service Accounts
- Users-Corp
- Workstations

---

## User and Computer Objects

The domain includes:

| Object | Type | Location |
|---|---|---|
| seif jied | Domain user | Users-Corp |
| CLIENT01 | Domain computer | Workstations |
| DC01 | Domain controller | Domain Controllers |

The Windows client `CLIENT01` was successfully joined to the `homelab.local` domain.

---

## DNS Validation

DNS was validated using:

```powershell
nslookup dc01.homelab.local
```

Expected result:

```text
dc01.homelab.local → 10.10.10.10
```

The client also successfully located the domain controller using:

```powershell
nltest /dsgetdc:homelab.local
```

---

## Domain Validation

The domain was validated using:

```powershell
dcdiag /test:dns
Get-ADDomain
whoami
```

The tests confirmed:

- DC01 is reachable
- DNS tests passed
- The domain is `homelab.local`
- CLIENT01 is joined to the domain
- The logged-in user is a domain user

---

## Validation Screenshots

Related screenshots:

```text
Screenshots/02-active-directory/01-dc01-ipconfig.png
Screenshots/02-active-directory/02-dc01-nslookup.png
Screenshots/02-active-directory/03-dc01-dcdiag-dns.png
Screenshots/02-active-directory/04-active-directory-domain-info.png
Screenshots/02-active-directory/05-ad-organizational-units.png
Screenshots/02-active-directory/06-ad-domain-users.png
Screenshots/02-active-directory/07-ad-domain-computers.png
Screenshots/03-client-domain/01-client01-ipconfig-domain.png
Screenshots/03-client-domain/02-client01-domain-validation.png
```

---

## Notes

DHCP is handled by pfSense instead of Windows Server.

This was done to keep pfSense as the central network gateway and DHCP provider, while DC01 handles Active Directory and DNS.

This setup works because DHCP provides the Windows clients with:

```text
DNS Server: 10.10.10.10
Domain: homelab.local
Gateway: 10.10.10.1
```

---

## Future Improvements

Possible improvements:

- Add Group Policy documentation
- Add file share documentation
- Create more domain users and groups
- Add a second domain controller for redundancy
- Add screenshots of GPO settings