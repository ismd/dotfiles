#!/usr/bin/env bash

call_feh () {
  feh --no-fehbg --recursive --bg-fill --randomize ~/Pictures/Wallpapers
}

kill -9 $(pgrep -f ${BASH_SOURCE[0]} | grep -v $$)
call_feh

while sleep 600; do
  call_feh
done
