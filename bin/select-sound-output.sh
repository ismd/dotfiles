#!/usr/bin/env bash

OUTPUT=$(echo -e "HDMI\nRazer" | dmenu -l 3 -fn "DaddyTimeMono Nerd Font-15" -p 'Select sound output:' -nb "#222D31" -nf "#F9FAF9" -sf "#F9FAF9" -sb "#16A085")

case $OUTPUT in
  HDMI) pactl set-default-sink alsa_output.pci-0000_2d_00.1.hdmi-stereo-extra1 ;;
  Razer) pactl set-default-sink alsa_output.usb-Razer_Razer_USB_Sound_Card_00000000-00.analog-stereo ;;
  *) echo "Specify output" ;;
esac
