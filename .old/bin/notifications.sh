#!/usr/bin/env bash

IS_PAUSED=$(dunstctl is-paused)

case "$1" in
  toggle)
    {
      if [ "$IS_PAUSED" == false ]; then
        notify-send -t 2000 -h string:x-canonical-private-synchronous:notifications-paused "🔕 Notifications"
        sleep 2s
      fi

      dunstctl set-paused toggle

      if [ "$IS_PAUSED" == true ]; then
        notify-send -t 2000 -h string:x-canonical-private-synchronous:notifications-paused "🔔 Notifications"
      fi
  };;

  *)
    echo invalid option;;
esac;
