#!/bin/bash

# Threshold percentage for disk usage
THRESHOLD=80

# Email to alert
EMAIL="your_email@example.com"

# Subject for email
SUBJECT="Disk Usage Alert on $(hostname)"

# Loop through each disk partition
df -h | grep '^/dev/' | while read line; do
  # Extract disk usage percentage and remove the '%' sign
  USAGE=$(echo $line | awk '{print $5}' | sed 's/%//')

  # Extract the mount point (e.g., /, /home, /var)
  PARTITION=$(echo $line | awk '{print $6}')

  # Check if usage exceeds threshold
  if [ "$USAGE" -ge "$THRESHOLD" ]; then
    # Compose the message
    MESSAGE="Warning: Disk usage on $PARTITION has reached ${USAGE}% on $(hostname) at $(date)"

    # Print to console
    echo "$MESSAGE"

    # Send an email (requires `mail` command to be configured)
    echo "$MESSAGE" | mail -s "$SUBJECT" "$EMAIL"
  fi
done
