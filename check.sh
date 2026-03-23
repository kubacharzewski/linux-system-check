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

CPU=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')

CPU_INT=${CPU%.*}

echo "CPU usage: ${CPU}%"

if [ "$CPU_INT" -gt 80 ]; then
   echo "WARNING: High CPU usage"
else
   echo "OK: CPU usage is normal"
fi

echo ""
echo "===Nginx status==="
systemctl is-active nginx
