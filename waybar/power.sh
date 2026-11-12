#!/bin/bash

choice=$(printf "  Shutdown\n  Reboot\n  Logout" | wofi --dmenu --prompt "Power" --width 200 --height 200 --cache-file /dev/null)

case "$choice" in
    *Shutdown) systemctl poweroff ;;
    *Reboot) systemctl reboot ;;
    *Logout) hyprctl dispatch exit ;;
esac
