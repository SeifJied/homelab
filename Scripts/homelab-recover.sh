#!/bin/bash
set -e

echo "=== Restarting Docker ==="
sudo systemctl restart docker

echo "Waiting for containers..."
sleep 10

echo "=== Restarting NGINX ==="
sudo systemctl restart nginx

echo "=== Restarting Wazuh Agent ==="
sudo systemctl restart wazuh-agent || true

echo "=== Restarting WireGuard ==="
sudo wg-quick down wg0 || true
sudo wg-quick up wg0 || true

echo "=== Status ==="
docker ps
sudo nginx -t
sudo fail2ban-client status
sudo wg

echo "Recovery completed."