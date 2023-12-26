#!/usr/bin/env bash

case "$1" in
  up)
  {
    wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+
    VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    notify-send -t 2000 -h string:x-canonical-private-synchronous:volume "$VOLUME"
  };;

  down)
  {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    notify-send -t 2000 -h string:x-canonical-private-synchronous:volume "$VOLUME"
  };;

  toggle)
  {
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    notify-send -t 2000 -h string:x-canonical-private-synchronous:volume "$VOLUME"
  };;

  *)
    echo "Invalid option";;
esac;
