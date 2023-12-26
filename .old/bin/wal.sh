#!/usr/bin/env bash

INPUT=${1:-$HOME/Pictures/Wallpapers/andrzej-kryszpiniuk-zUqFqeG03-k-unsplash.jpg}

wal -i $INPUT
pywalfox update
#wal-telegram -w
