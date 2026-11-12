#!/bin/bash
cat << 'MENU' | wofi --dmenu --prompt "Shortcuts" --width 600 --height 500 --cache-file /dev/null
  Super + Return  : Terminal
  Super + Space   : App Launcher
  Super + Q       : Close Window
  Super + M       : Fullscreen
  Super + F       : Toggle Floating
  Super + /       : This Cheat Sheet
  Super + G       : Overview
  Super + Shift+G : Gamemode
  Super + W       : Next Wallpaper
  Super + C       : Chrome
  Super + V       : VS Code
  Super + S       : Spotify
  Super + E       : File Manager
  Super + Ctrl+L  : Lock Screen
  Print           : Screenshot (Swappy)
  Super + Print   : Full Screenshot
  Super + Shift+1 : Move window to WS 1
  Super + 1..0    : Switch Workspaces
MENU
