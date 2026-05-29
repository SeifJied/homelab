# Wazuh SIEM

## Purpose

This document explains how Wazuh is used in the homelab.

The goal was to practice basic SIEM concepts such as agent deployment, log collection, security events, and centralized visibility.

---

## Wazuh Components

The Wazuh setup includes:

| Component | Role | IP Address |
|---|---|---|
| Wazuh Server | Manager / Indexer / Dashboard | 10.10.10.30 |
| DC01 Agent | Windows Server agent | 10.10.10.10 |
| CLIENT01 Agent | Windows client agent | 10.10.10.100 / 10.200.200.2 |
| WEB01 Agent | Ubuntu server agent | 10.10.10.20 |

---

## Agents

The Wazuh dashboard shows three active agents:

- DC01
- CLIENT01
- WEB01

All agents were active during validation.

This confirms that Windows and Linux systems were connected to the Wazuh manager.

---

## Ubuntu Agent Configuration

The Ubuntu Wazuh agent is configured to send events to:

```text
10.10.10.30:1514/tcp
```

The agent service was validated with:

```bash
sudo systemctl status wazuh-agent --no-pager
```

---

## nginx Log Collection

The WEB01 Wazuh agent collects nginx logs from:

```text
/var/log/nginx/access.log
/var/log/nginx/error.log
```

The log format used is:

```text
apache
```

This allows Wazuh to analyze web server activity from nginx.

---

## Security Events

Wazuh Threat Hunting was used to view nginx-related events.

The validation showed nginx events from the WEB01 agent, including Wazuh rule information such as:

- agent name
- rule description
- rule level
- rule ID
- timestamp

---

## Validation

Wazuh was validated by checking:

- Wazuh dashboard access
- active agents
- Wazuh agent service status
- manager IP configuration
- nginx log collection configuration
- nginx security events in Threat Hunting

---

## Validation Screenshots

Related screenshots:

```text
Screenshots/08-wazuh-siem/01-wazuh-dashboard-home.png
Screenshots/08-wazuh-siem/02-wazuh-agents-active.png
Screenshots/08-wazuh-siem/03-wazuh-agent-service-status.png
Screenshots/08-wazuh-siem/04-wazuh-agent-manager-config.png
Screenshots/08-wazuh-siem/05-wazuh-nginx-log-collection-config.png
Screenshots/08-wazuh-siem/06-wazuh-nginx-security-events.png
```

---

## Notes

This Wazuh setup is focused on basic SIEM practice and log visibility.

The current detection work is simple, but it provides a base for future custom detection rules and MITRE ATT&CK mapping.

---

## Future Improvements

Possible improvements:

- Add more custom Wazuh rules
- Add stronger web attack detection
- Add MITRE ATT&CK screenshots
- Add more detailed alert examples
- Add Windows event log use cases
- Add automated alert documentation