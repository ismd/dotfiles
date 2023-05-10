#!/usr/bin/env bash

call_feh () {
  feh --no-fehbg --recursive --bg-fill --randomize ~/Pictures/Wallpapers
}

call_feh

while sleep 600; do
  call_feh
done
