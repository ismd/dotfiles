#!/usr/bin/env bash

INPUT=${1:-$HOME/Pictures/Wallpapers/daniele-buso-qzUenL35ZYw-unsplash.jpg}

wal -i $INPUT
pywalfox update
wal-telegram -w
