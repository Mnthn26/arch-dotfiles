#!/bin/bash
while true; do
    # Wait for the webcam to be turned on
    inotifywait -e open /dev/video0 >/dev/null 2>&1
    
    # Send a nice Catppuccin notification
    notify-send -t 3000 -i camera-web -h string:x-canonical-private-synchronous:"howdy" "Face Unlock" "Scanning face..."
    
    # Wait 3 seconds to prevent the notification from spamming if the camera blinks
    sleep 3
done
