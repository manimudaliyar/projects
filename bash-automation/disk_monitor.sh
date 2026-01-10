#!/bin/bash

# This script checks disk usage on / and exits non-zero if a threshold is exceeded

# Set the threshold percentage (e.g., 80 for 80%)
THRESHOLD=80

# Create log file if not already exists
touch $HOME/devops/projects/bash-automation/logs/disk_monitor.log

# Log file to record disk usage
LOG_FILE="$HOME/devops/projects/bash-automation/logs/disk_monitor.log"

# Get current date and time
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')

# Check disk usage and filter for root filesystem
DISK_USAGE=$( df -P / | awk 'NR==2 {gsub(/%/, "",$5); print $5}' )

# Check if disk usage exceeds the threshold
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]
then
    # Log the alert with timestamp
    echo "$CURRENT_TIME - Alert: Disk usage is at $DISK_USAGE% which exceeds the threshold of $THRESHOLD%." >> "$LOG_FILE"
    echo "Alert: Disk usage is at $DISK_USAGE% which exceeds the threshold of $THRESHOLD%."
    exit 1
else
    echo "$CURRENT_TIME - Disk usage is at $DISK_USAGE%, which is within the safe limit." >> "$LOG_FILE"
    echo "Disk usage is at $DISK_USAGE%, which is within the safe limit."
    exit 0
fi

# End of script