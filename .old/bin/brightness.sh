#!/usr/bin/env bash

case "$1" in
  up)
    brightnessctl s +5%
    ;;

  down)
    brightnessctl s 5%-
    ;;

  *)
    echo "Choose between up and down"
    exit 1
esac;

notify-send -t 2000 -h string:x-canonical-private-synchronous:brightness "🔆 Brightness: $(brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}')%"
