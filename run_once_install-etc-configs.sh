#!/usr/bin/env bash

set -euo pipefail

CHEZMOI_SOURCE="${HOME}/.local/share/chezmoi"

# Install logind.conf
LOGIND_CONF="${CHEZMOI_SOURCE}/etc/systemd/logind.conf"
if [[ -f "$LOGIND_CONF" ]]; then
    echo "Installing logind.conf to /etc/systemd/..."
    sudo cp "$LOGIND_CONF" /etc/systemd/logind.conf
fi

# Install plymouthd.conf
PLYMOUTH_CONF="${CHEZMOI_SOURCE}/etc/plymouth/plymouthd.conf"
if [[ -f "$PLYMOUTH_CONF" ]]; then
    echo "Installing plymouthd.conf to /etc/plymouth/..."
    sudo cp "$PLYMOUTH_CONF" /etc/plymouth/plymouthd.conf
fi

echo "Done."