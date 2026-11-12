#!/bin/bash

# A temporary file to track whether we are in gamemode
STATE_FILE="/tmp/hypr_gamemode_active"

if [ -f "$STATE_FILE" ]; then
    # Currently in gamemode, turn everything back on
    hyprctl keyword animations:enabled true
    hyprctl keyword decoration:blur:enabled true
    hyprctl keyword general:gaps_in 5
    hyprctl keyword general:gaps_out 10
    hyprctl keyword decoration:rounding 10
    
    rm "$STATE_FILE"
    notify-send -t 3000 -i preferences-system "Gamemode OFF" "Aesthetics restored (Blur & Animations ON)"
else
    # Currently normal, turn everything off
    hyprctl keyword animations:enabled false
    hyprctl keyword decoration:blur:enabled false
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
    hyprctl keyword decoration:rounding 0
    
    touch "$STATE_FILE"
    notify-send -t 3000 -i preferences-system "Gamemode ON" "Performance maximized (Blur & Animations OFF)"
fi
