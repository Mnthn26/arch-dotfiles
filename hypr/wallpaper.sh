#!/bin/bash
DIR=/usr/share/backgrounds/archlinux
LIST=(archbtw geowaves geolanes gritty wireparts archwave)
STATE=~/.cache/current-wallpaper

last=$(cat "$STATE" 2>/dev/null)
while :; do
    pick=${LIST[RANDOM % ${#LIST[@]}]}
    [ "$pick" != "$last" ] && break
done
echo "$pick" > "$STATE"

pkill -x swaybg
nohup swaybg -i "$DIR/$pick.png" -m fill >/dev/null 2>&1 &
