#!/usr/bin/env bash

if [[ ! $(pgrep gammastep) ]]; then
  gammastep-indicator &
fi
