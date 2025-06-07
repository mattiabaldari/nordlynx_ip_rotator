#!/bin/bash
# /root/restart_wireguard.sh

# Kill the wireguard service process (s6-overlay will automatically restart it)
s6-svc -k /var/run/service/wireguard
sleep 10

# Check if curl ifconfig.me runs successfully
if ! curl -s --max-time 10 ifconfig.me > /dev/null; then
  echo "[$(date -Iseconds)] Network check failed, waiting 60 seconds before retrying restart"
  sleep 60

  # Kill the wireguard service process (s6-overlay will automatically restart it)
  s6-svc -k /var/run/service/wireguard
fi

echo "[$(date -Iseconds)] Wireguard service restarted"