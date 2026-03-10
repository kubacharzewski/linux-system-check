#!/bin/bash

echo "System check: $(date)"
echo ""

echo "===System info==="
hostname

echo ""
echo "===Uptime==="
uptime

echo ""
echo "===Disk usage==="
df -h

echo ""
echo "===Memory==="
free -h

echo ""
echo "===Nginx status==="
systemctl is-active nginx
