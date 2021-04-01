#!/usr/bin/env bash
xset -dpms
xset s off
xset r rate 250 20
setxkbmap -layout us,ru -option grp:toggle
xmodmap ~/.Xmodmap
feh --bg-fill --randomize ~/Pictures/Wallpapers
