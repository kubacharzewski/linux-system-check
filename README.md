# Linux System Check Script
Simple bash script for monitoring basic system health.

## Features
- System information (hostname, OS)
- Uptime
- Disk usage
- Memory usage
- CPU usage
- Nginx service status
- Logging to file
- Automatic execution via cron

## Requirements
- Linux system
- bash
- vmstat
- systemctl

## Usage
### 1. Make script executable
chmod +x check.sh

### 2. Run manually
./check.sh

### 3. Output
Results are saved to:
system_check.log

## Cron (automatic execution)
Run script every 5 minutes:
crontab -e
Add:
*/5 * * * * cd /home/jakub/linux-system-check && /bin/bash check.sh

## Monitoring logs
### Live view (recommended)
less -R +F system_check.log

### Alternative
tail -f system_check.log

## How it works
The script collects system metrics and appends them to a log file.
Cron is used to run the script automatically every 5 minutes.

## Author
Jakub Charzewski
