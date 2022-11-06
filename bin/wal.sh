#!/usr/bin/env bash

#INPUT=${1:-$HOME/Pictures/Wallpapers}
#INPUT=${1:-$HOME/Pictures/Wallpapers/john-fowler-onYwpkAI8ow-unsplash.jpg}
INPUT=${1:-$HOME/Pictures/Wallpapers/johannes-plenio-J9oL7OBGSns-unsplash.jpg}

wal -i $INPUT
pywalfox update
wal-telegram -w
