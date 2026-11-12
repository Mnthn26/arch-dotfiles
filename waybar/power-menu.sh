#!/bin/bash
chosen=$(printf "🔒 Lock\n🚪 Logout\n🔄 Reboot\n⏻ Shutdown" | wofi --dmenu -p "Power Menu" --width 250 --height 210)

case "$chosen" in
    "🔒 Lock") swaylock -f -c 000000 ;;
    "🚪 Logout") hyprctl dispatch exit ;;
    "🔄 Reboot") systemctl reboot ;;
    "⏻ Shutdown") systemctl poweroff ;;
esac
