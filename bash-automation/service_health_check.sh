#!/bin/bash

# service_health_check.sh
# Checks whether given systemd services are active.
# Exits non-zero if any service is not running.

# Example:
# ./service_health_check.sh docker ssh

# 1. Ensure at least one service name is provided
if [ "$#" -eq 0 ];
then
    echo "Usage: $0 <service_name1> [service_name2 ...]"
    exit 1
fi

# 2. Track overall health
STATUS=0

# 3. Loop through each provided service name
for SERVICE in "$@";
do
    # Check if service is active
    if systemctl is-active --quiet "$SERVICE";
    then
        echo "OK: Service '$SERVICE' is running."
    else
        echo "ERROR: Service '$SERVICE' is not running."
        STATUS=1
    fi
done

# 4. Exit with appropriate status
exit "$STATUS"