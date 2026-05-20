#!/bin/bash

LOG_FILE="/var/log/disk_monitor.log"
THRESHOLD=80
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "[$TIMESTAMP] Disk usage check:" >> "$LOG_FILE"

df -H | grep -vE '^Filesystem|tmpfs|cdrom|udev' | while read -r line; do
    usage=$(echo "$line" | awk '{print $5}' | tr -d '%')
    filesystem=$(echo "$line" | awk '{print $1}')
    mountpoint=$(echo "$line" | awk '{print $6}')

    echo "  $filesystem ($mountpoint): ${usage}%" >> "$LOG_FILE"

    if [ "$usage" -ge "$THRESHOLD" ]; then
        echo "ALERT: $filesystem mounted at $mountpoint is at ${usage}% capacity!"
        echo "  *** ALERT: $filesystem at ${usage}% ***" >> "$LOG_FILE"
    fi
done

echo "" >> "$LOG_FILE"
