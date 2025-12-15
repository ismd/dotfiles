#!/usr/bin/env bash

set -e

if ! command -v brightnessctl &> /dev/null; then
  echo "Error: brightnessctl not found"
  exit 1
fi

case $1 in
  "up")
    brightnessctl -e4 set 5%+ > /dev/null 2>&1
    ;;
  "down")
    brightnessctl -e4 set 5%- > /dev/null 2>&1
    ;;
  *)
    echo "Usage: $0 {up|down}"
    exit 1
    ;;
esac

percentage=$(brightnessctl -m | cut -d, -f4 | tr -d %)

notify-send -t 1000 -h string:x-canonical-private-synchronous:brightness \
  -i display-brightness-symbolic \
  "Brightness" "${percentage}%"
