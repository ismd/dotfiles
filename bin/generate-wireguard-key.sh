#!/usr/bin/env bash
FILENAME=$1

if [[ -z $FILENAME ]]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

wg genkey | tee ./${FILENAME}.key | wg pubkey | tee ./${FILENAME}.key.pub
