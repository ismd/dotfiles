#!/usr/bin/env bash

function run {
    if ! pgrep -f $1 ;
    then
        $@&
    fi
}

#xsetroot -solid "#333333"
~/.fehbg
xset -dpms
xset s off
xset r rate 300 25
setxkbmap -layout us,ru -option grp:toggle

# run compton -cCGfF -o 0.38 -O 200 -I 200 -t 0 -l 0 -r 3 -D2 -m 0.88
run compton -f --vsync drm
run dunst
run screenshotgun
run telegram-desktop
run udiskie --no-automount --no-notify --tray
run unclutter --timeout 2
run xxkb
run redshift-gtk -t 5500:4500
