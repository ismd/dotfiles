#!/usr/bin/env bash

set -euo pipefail

gotroot=$(sh -c "sudo -vn" 2>&1 || true | regexMatch "password")

if [ -n "$gotroot" ]; then
    echo "Sudo access is required to run this script. Authorize sudo and try again."
    exit 1
fi

yay -Sy --noconfirm --needed \
    ark \
    bitwarden-desktop \
    dms-shell-bin \
    dolphin \
    elephant \
    emacs-wayland \
    ffmpeg \
    fwupd \
    gimp \
    git \
    github-cli \
    hypridle \
    hyprpolkitagent \
    imagemagick \
    neovim \
    noto-fonts-emoji \
    plymouth \
    ripgrep \
    socat
