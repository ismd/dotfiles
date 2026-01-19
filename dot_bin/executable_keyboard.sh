#!/usr/bin/env bash
set -euo pipefail

notify-send "Configuring keyboard"
setxkbmap -model pc104 -layout us,ru -option grp:toggle,ctrl:nocaps
xset r rate 300 25
