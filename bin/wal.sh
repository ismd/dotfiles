#!/usr/bin/env bash

INPUT=${1:-$HOME/Pictures/Wallpapers}

wal -i $INPUT
pywalfox update
wal-telegram -w
