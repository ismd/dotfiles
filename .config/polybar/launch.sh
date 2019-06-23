#!/bin/bash

PRIMARY_OUTPUT="HDMI-A-0"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for m in $(polybar --list-monitors | cut -d":" -f1); do
    if [ $m == $PRIMARY_OUTPUT ]; then
        TRAY_POS=right
    else
        TRAY_POS=none
    fi

    MONITOR=$m \
    BAR_HEIGHT=27 \
    FONT0="Hack:fontformat=truetype:size=10;2" \
    FONT1="Hack:fontformat=truetype:size=10;2" \
    FONT2="FontAwesome:fontformat=truetype:size=10;2" \
    TRAY_POS=$TRAY_POS \
    polybar --reload my &
done

echo "Polybar launched..."
