#!/usr/bin/env bash
# https://askubuntu.com/questions/26068/how-do-you-mute-from-the-command-line

DEFAULT_SINK=$(pactl info | grep "Default Sink" | cut -d " " -f3)

IS_MUTE=$(pactl list | grep -E "Name: $DEFAULT_SINK$|Mute" | grep "Name:" -A1 | tail -1 |cut -d: -f2| tr -d " ")

if [ "$IS_MUTE" == no ]; then
  UNMUTE=1
else
  UNMUTE=0
fi

case "$1" in
  up)
  {
    pactl set-sink-volume "$DEFAULT_SINK" +5%
    VOLUME=$(pactl list | grep -E "Name: $DEFAULT_SINK$|Volume" | grep "Name:" -A1 | tail -1 | cut -d% -f1 | cut -d/ -f2 | tr -d " ")

    if [ "$UNMUTE" == 1 ]; then
      ICON="$(echo -ne "\U1F50A")"
    else
      ICON="$(echo -ne "\U1F507")"
    fi

    notify-send -t 2000 -h string:x-canonical-private-synchronous:volume "$ICON Volume $VOLUME%"
  };;

  down)
  {
    pactl set-sink-volume "$DEFAULT_SINK" -5%
    VOLUME=$(pactl list | grep -E "Name: $DEFAULT_SINK$|Volume" | grep "Name:" -A1 | tail -1 | cut -d% -f1 | cut -d/ -f2 | tr -d " ")

    if [ "$UNMUTE" == 1 ]; then
      ICON="$(echo -ne "\U1F509")"
    else
      ICON="$(echo -ne "\U1F507")"
    fi

    notify-send -t 2000 -h string:x-canonical-private-synchronous:volume "$ICON Volume $VOLUME%"
  };;

  toggle)
  {
    pactl set-sink-mute "$DEFAULT_SINK" "$UNMUTE"
    sudo sh -c 'echo 0 > /sys/devices/platform/thinkpad_acpi/leds/platform::mute/brightness'
    VOLUME=$(pactl list | grep -E "Name: $DEFAULT_SINK$|Volume" | grep "Name:" -A1 | tail -1 | cut -d% -f1 | cut -d/ -f2 | tr -d " ")

    if [ "$UNMUTE" == 1 ]; then
      ICON="$(echo -ne "\U1F507")"
    else
      ICON="🔊"
    fi

    notify-send -t 2000 -h string:x-canonical-private-synchronous:volume "$ICON Volume $VOLUME%"
  };;

  *)
    echo invalid option;;
esac;
