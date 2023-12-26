#!/usr/bin/env bash

while true; do
  BAT=$(acpi -s | cut -d' ' -f4 | sed 's/.$//' | sed 's/.$//')

  if [ $BAT -le 9  ]; then
    notify-send "Low battery"
    sleep 60s
  fi
  sleep 5s
done &
