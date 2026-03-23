#!/bin/bash

echo "System check: $(date)"
echo ""

echo "===System info==="
echo "Hostname: $(hostname)"

. /etc/os-release
echo "OS: $PRETTY_NAME"

echo ""
echo "===Uptime==="

UPTIME=$(uptime -p)

echo "Uptime: ${UPTIME#up}"

echo ""
echo "===Disk usage==="

DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Disk usage:  ${DISK}%"

if [ "$DISK" -gt 80 ]; then
   echo "WARNING: High disk usage"
else
   echo "OK: Disk usage normal"
fi

echo ""
echo "===Memory==="

MEM=$(free | awk '/Mem/ {printf("%.0f", $3/$2 * 100)}')

echo "Memory usage: ${MEM}%"

if [ "$MEM" -gt 80 ]; then
   echo "WARNING: High memory usage"
else
   echo "OK: Memory usage normal"
fi

echo ""
echo "===CPU==="

CPU_IDLE=$(vmstat 1 2 | tail -1 | awk '{print $15}')
CPU=$((100 - CPU_IDLE))

echo "CPU usage: ${CPU}%"

if [ "$CPU" -gt 80 ]; then
   echo "WARNING: High CPU usage"
else
   echo "OK: CPU usage is normal"
fi

echo ""
echo "===Nginx status==="
systemctl is-active nginx
