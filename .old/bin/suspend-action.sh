#!/usr/bin/env bash

DIRNAME="$(dirname -- "$0")"

$DIRNAME/lock-screen.sh
$DIRNAME/volume.sh off
