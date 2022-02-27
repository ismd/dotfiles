#!/usr/bin/env bash
xset -dpms
xset s off
xset r rate 250 20
setxkbmap -model hhk -layout us,ru -option grp:toggle
xmodmap ~/.Xmodmap
#gammastep -P -O 6200
