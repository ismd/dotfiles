#!/usr/bin/env bash

#INPUT=${1:-$HOME/Pictures/Wallpapers}
#INPUT=${1:-$HOME/Pictures/Wallpapers/john-fowler-onYwpkAI8ow-unsplash.jpg}
INPUT=${1:-$HOME/Pictures/wide-wallpaper-1680x1050-001.jpg}

wal -i $INPUT
pywalfox update
wal-telegram -w
