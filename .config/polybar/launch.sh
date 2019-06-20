#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for m in $(polybar --list-monitors | cut -d":" -f1); do
    if [ $m == 'HDMI-A-0' ] 
    then
        echo $m
        MONITOR=$m TRAY_POS=center polybar --reload my &
    else
        echo $m
        MONITOR=$m TRAY_POS=none polybar --reload my &
    fi
done

echo "Polybar launched..."
