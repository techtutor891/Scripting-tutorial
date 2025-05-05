:<<'END_COMMENT'
Problem:
Write a Bash script that checks the disk usage of a specific directory (default to /home if none is provided) and sends an alert (prints a warning message) if the usage exceeds a specified threshold.

Requirements:
Accept two optional arguments:

Directory path (default: /home)

Threshold percentage (default: 80%)

Use du and/or df to calculate usage.

Print a message like:
"Warning: /home is using 85% of disk space, which exceeds the threshold of 80%."

END_COMMENT





#!/bin/bash

# Default values
DIR="${1:-/home}"
THRESHOLD="${2:-80}"

# Validate that the directory exists
if [[ ! -d "$DIR" ]]; then
    echo "Error: '$DIR' is not a valid directory."
    exit 1
fi

# Validate that the threshold is a number between 1 and 100
if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]] || (( THRESHOLD < 1 || THRESHOLD > 100 )); then
    echo "Error: Threshold must be a number between 1 and 100."
    exit 1
fi

# Get disk usage percentage (without % symbol) for the filesystem the directory is on
USAGE=$(df -h "$DIR" | awk 'NR==2 {gsub("%",""); print $5}')

# Compare usage with threshold
if (( USAGE > THRESHOLD )); then
    echo "⚠️  Warning: $DIR is using ${USAGE}% of disk space, which exceeds the threshold of ${THRESHOLD}%."
else
    echo "✅ $DIR is using ${USAGE}% of disk space. All good!"
fi


#outpput argument
#   ./disk_alert.sh /var 90 
#    chmod +x disk_alert.sh


