#!/bin/bash
ARCH_DIR="/usr/share/backgrounds/archlinux"
STATE_FILE="$HOME/.cache/current-wallpaper"

# Get list of all Arch wallpapers
mapfile -t WALLPAPERS < <(find "$ARCH_DIR" -type f -name '*.png')

if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    echo "No Arch wallpapers found in $ARCH_DIR"
    exit 1
fi

# Get the last used wallpaper to avoid repeats
last=$(cat "$STATE_FILE" 2>/dev/null)

# Loop until we find one that isn't the last one
while :; do
    picked=${WALLPAPERS[RANDOM % ${#WALLPAPERS[@]}]}
    [ "$picked" != "$last" ] && break
done

# Save the new choice
echo "$picked" > "$STATE_FILE"

# Kill old swaybg and start the new one
pkill -x swaybg
nohup swaybg -i "$picked" -m fill >/dev/null 2>&1 &
