# Box Title

## Introduction

A really wild exploit leads to another wild exploit and the user exploits it.

## Info for HTB

### Access

Passwords:

| User  | Password                            |
| ----- | ----------------------------------- |
| user  | password                            |
| root  | password                            |

### Key Processes

- **Web Server**: Hosts the web server
- **Binary File**: The privelege escalation vector

### Automation / Crons

A cron job runs every 3 seconds to check for XSS.

### Firewall Rules

- **IPv6**: Disabled
- **Inbound Rules**:
  - Port 22 allowed
  - Port 80 allowed
  - ICMP allowed
- **Outbound Rules**:
  - Port 22 allowed
  - Port 53 allowed
  - Port 80 allowed
  - ICMP allowed

### Future Proofing

Do not upgrade the Binary File because it is only vulnerable at the current version.

The Web Server may be upgraded but should be checked for breaking changes.
