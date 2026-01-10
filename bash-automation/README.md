# Disk Monitor script

This script checks the disk usage for the root '/' directory and exits non-zero if a defined threshold is exceeded.

## Usage

Run the script by running ./disk_monitor.sh command from the directory the script is present in.

Make sure the script has permissions to be exceuted. If not, run: 

chmod +x disk_monitor.sh

## Behavior

- Exits with status code `0` if disk usage is within the safe limit
- Exits with status code `1` if disk usage exceeds the configured threshold
- Appends disk usage status to a log file for reference