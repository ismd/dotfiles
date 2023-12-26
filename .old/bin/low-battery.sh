#!/usr/bin/env bash

DIRNAME="$(dirname -- "$0")"

$DIRNAME/volume.sh off
/usr/bin/systemctl hibernate
