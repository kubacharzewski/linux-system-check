#!/bin/bash

LOG_FILE="system_check.log"
> $LOG_FILE

echo "System check: $(date)" | tee -a $LOG_FILE
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

echo "Disk usage:  ${DISK}%" | tee -a $LOG_FILE

if [ "$DISK" -gt 80 ]; then
   echo "WARNING: High disk usage" | tee -a $LOG_FILE
else
   echo "OK: Disk usage normal" | tee - a $LOG_FILE
fi

echo ""
echo "===Memory==="

MEM=$(free | awk '/Mem/ {printf("%.0f", $3/$2 * 100)}')

echo "Memory usage: ${MEM}%" | tee -a $LOG_FILE

if [ "$MEM" -gt 80 ]; then
   echo "WARNING: High memory usage" | tee -a $LOG_FILE
else
   echo "OK: Memory usage normal" | tee -a $LOG_FILE
fi

echo ""
echo "===CPU==="

CPU_IDLE=$(vmstat 1 2 | tail -1 | awk '{print $15}')
CPU=$((100 - CPU_IDLE))

echo "CPU usage: ${CPU}%" | tee -a $LOG_FILE

if [ "$CPU" -gt 80 ]; then
   echo "WARNING: High CPU usage" | tee -a $LOG_FILE
else
   echo "OK: CPU usage normal" | tee -a $LOG_FILE
fi

echo ""
echo "===Nginx status==="

if systemctl is-active --quiet nginx; then
   echo "OK: Nginx is running" | tee -a $LOG_FILE
else
   echo "WARNING: Nginx is not running" | tee -a $LOG_FILE
fi
