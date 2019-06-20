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

run alacritty -e tmux
run nextcloud
run nm-applet
run screenshotgun
run telegram-desktop
run udiskie --no-automount --no-notify --tray --use-udisks2
run unclutter --timeout 2
