#!/usr/bin/env bash

function run {
    if ! pgrep -f $1 ;
    then
        $@&
    fi
}

xsetroot -solid "#333333"
xset -dpms
xset s off
setxkbmap -layout us,ru -option grp:toggle

run nextcloud
run screenshotgun
run telegram-desktop
run terminator -e tmux
run udiskie --no-automount --no-notify --tray --use-udisks2
run unclutter --timeout 2
