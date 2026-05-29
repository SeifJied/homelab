#!/bin/bash

echo "=== HOSTNAME ==="
hostnamectl

echo
echo "=== IP ADDRESSES ==="
ip a

echo
echo "=== ROUTES ==="
ip r

echo
echo "=== DNS ==="
resolvectl status | grep -A5 "Link"

echo
echo "=== DOCKER CONTAINERS ==="
docker ps

echo
echo "=== NGINX STATUS ==="
systemctl status nginx --no-pager

echo
echo "=== NGINX CONFIG TEST ==="
sudo nginx -t

echo
echo "=== FAIL2BAN STATUS ==="
sudo fail2ban-client status

echo
echo "=== WIREGUARD STATUS ==="
sudo wg

echo
echo "=== LISTENING PORTS ==="
sudo ss -tulpn