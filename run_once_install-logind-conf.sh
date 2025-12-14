#!/usr/bin/env bash

set -euo pipefail

CHEZMOI_SOURCE="${HOME}/.local/share/chezmoi"
LOGIND_CONF="${CHEZMOI_SOURCE}/etc/systemd/logind.conf"

if [[ -f "$LOGIND_CONF" ]]; then
    echo "Installing logind.conf to /etc/systemd/..."
    sudo cp "$LOGIND_CONF" /etc/systemd/logind.conf
    echo "Done. You may need to restart systemd-logind: sudo systemctl restart systemd-logind"
fi
