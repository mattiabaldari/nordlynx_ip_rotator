#!/bin/bash
# /root/restart_wireguard.sh

# Kill the wireguard service process (s6-overlay will automatically restart it)
s6-svc -k /var/run/service/wireguard

echo "[$(date -Iseconds)] Wireguard service restarted"