#!/bin/bash
WALL_DIR="$HOME/Pictures/Wallpapers"
ARCH_DIR="/usr/share/backgrounds/archlinux"

# Check if the custom folder has images
if [ -d "$WALL_DIR" ] && [ "$(ls -A "$WALL_DIR" 2>/dev/null)" ]; then
    # Pick a random image from the custom folder
    WALLPAPER=$(find "$WALL_DIR" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' \) | shuf -n 1)
else
    # Fallback to Arch defaults if custom folder is empty
    LIST=(archbtw geowaves geolanes gritty wireparts archwave)
    pick=${LIST[RANDOM % ${#LIST[@]}]}
    WALLPAPER="$ARCH_DIR/$pick.png"
fi

# Ensure we found something
if [ -z "$WALLPAPER" ]; then
    exit 1
fi

# Kill old swaybg and start the new one
pkill -x swaybg
nohup swaybg -i "$WALLPAPER" -m fill >/dev/null 2>&1 &
