#!/bin/bash

echo "=== HOMELAB WEB HEALTHCHECK ==="

urls=(
  "https://grafana.homelab.local"
  "https://status.homelab.local"
  "https://portainer.homelab.local"
  "https://prometheus.homelab.local"
  "https://dvwa.homelab.local"
  "https://juice.homelab.local"
  "https://wazuh.homelab.local"
)

for url in "${urls[@]}"; do
  echo
  echo "Testing: $url"
  curl -k -s --max-time 5 -I "$url" | head -n 1
done