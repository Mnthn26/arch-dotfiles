#!/bin/bash
choice=$(printf "Logout\nReboot\nShutdown" | wofi --dmenu --prompt "Power" --width 220 --height 170)
case "$choice" in
    Logout)   hyprctl dispatch 'hl.dsp.exit()' ;;
    Reboot)   systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
esac
