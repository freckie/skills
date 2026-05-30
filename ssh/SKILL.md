---
name: ssh
description: SSH Guidelines
user-invocable: false
---

# SSH Guidelines

## Available Servers

Read `~/.ssh/config` to get the up-to-date list of available SSH hosts before connecting.

## Connection Announcement (ALWAYS)

**Every time** you run an SSH command, you MUST announce the target host to the user **before** executing the command. Format:

```
[ SSH ]
 > Connecting to: <Host alias> (<HostName> as <User>)
```

Example:
```
[ SSH ]
 > Connecting to: idp (10.40.130.187 as ec2-user)
```

## Operation Classification

### Read-Only Operations (allowed without asking)

These are safe, non-destructive commands. Proceed without asking for permission:

- Viewing files: `cat`, `less`, `head`, `tail`, `find`, `ls`, `stat`
- System inspection: `ps`, `top`, `df`, `du`, `free`, `uname`, `uptime`, `who`, `id`
- Network inspection: `netstat`, `ss`, `ip addr`, `ping`, `curl` (GET only), `wget` (read only)
- Log inspection: `journalctl`, `dmesg`, `tail -f` on log files
- Process inspection: `systemctl status`, `docker ps`, `docker logs`, `docker inspect`
- Config reading: any command that only reads configuration files
- Environment inspection: `env`, `echo $VAR`, `which`, `type`

### Write / Destructive Operations (MUST ask permission first)

These commands modify system state. **Always ask the user for explicit permission before executing:**

- Writing files: `echo ... >`, `tee`, `cp`, `mv`, `mkdir`, `rm`, `chmod`, `chown`
- Editing files: `vi`, `vim`, `nano`, `sed -i`, `awk` with output redirection
- Package management: `apt`, `yum`, `dnf`, `pip install`, `npm install`
- Service management: `systemctl start/stop/restart/enable/disable`, `service ...`
- Container operations: `docker run`, `docker stop`, `docker start`, `docker restart`, `docker rm`, `docker pull`, `docker-compose up/down`
- Process management: `kill`, `pkill`, `killall`
- Network changes: `iptables`, `ufw`, `firewall-cmd`
- Running scripts: executing any `.sh` or deployment scripts
- Cron changes: editing crontab

## Permission Request Format

When a write/destructive operation is needed, present it clearly before asking:

```
[ SSH Request ]
 > Host: <alias> (<HostName>)
 > Operation: <brief description>
 > Command: <exact command to be run>
```

Wait for explicit confirmation before executing.

## Multi-command Sessions

If a task requires multiple SSH commands in sequence:
- List all planned commands (read and write) upfront.
- Batch-confirm all write/destructive commands at once rather than asking one by one.
- Still announce the host before each connection.
