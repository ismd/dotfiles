#!/usr/bin/env bash

notify-send "Configuring keyboard"
setxkbmap -model pc104 -layout us,ru -option grp:toggle,ctrl:nocaps
xset r rate 300 25
