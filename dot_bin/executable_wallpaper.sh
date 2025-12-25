#!/usr/bin/env bash
set -e

WALLPAPERS_DIR="$HOME/Pictures/Wallpapers"
WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)

wal -n -i "$WALLPAPER"

swww img "$WALLPAPER" \
  --transition-type fade \
  --transition-fps 60 \
  --transition-duration 2

kitty @ --to unix:@kitty-$USER set-colors --all ~/.cache/wal/colors-kitty.conf 2>/dev/null || true
