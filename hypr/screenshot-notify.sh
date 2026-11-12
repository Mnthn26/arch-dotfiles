#!/bin/bash

# A unique ID for this notification so we can replace it
ID="screenshot-$$"

# Send the initial notification with the progress bar full (100%)
notify-send -t 10000 -i camera-photo \
    -h string:x-canonical-private-synchronous:"$ID" \
    -h int:value:100 \
    "Screenshot Captured" "Full screen copied to clipboard"

# Loop 10 times, once per second, to update the progress bar
for i in {9..0}; do
    # Convert the loop counter to a percentage (e.g., 90, 80, ...)
    percent=$((i * 10))
    
    # Update the notification with the new progress value
    # The x-canonical-private-synchronous hint replaces the previous notification
    notify-send -t 10000 -i camera-photo \
        -h string:x-canonical-private-synchronous:"$ID" \
        -h int:value:"$percent" \
        "Screenshot Captured" "Full screen copied to clipboard"
    
    sleep 1
done
