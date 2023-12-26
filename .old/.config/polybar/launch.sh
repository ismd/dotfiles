#!/usr/bin/env bash
polybar-msg cmd quit

PRIMARY=$(xrandr -q | grep " primary " | cut -d" " -f1)

if type "xrandr"; then
  for m in $(xrandr -q | grep " connected " | cut -d" " -f1); do
    if [[ $m == $PRIMARY ]]; then
      TRAY_POSITION=right
    else
      TRAY_POSITION=
    fi

    MONITOR=$m TRAY_POSITION=$TRAY_POSITION polybar --reload my &
  done
else
  polybar --reload my &
fi

disown
echo "Polybar launched..."
