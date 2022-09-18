#!/usr/bin/env bash
polybar-msg cmd quit

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload my &
    disown
  done
else
  polybar --reload my &
  disown
fi

echo "Polybar launched..."
