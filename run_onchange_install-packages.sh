#!/usr/bin/env bash

set -euo pipefail

gotroot = sh -c sudo -vn 2>&1 || true | regexMatch "password"

if [ -n "$gotroot" ]; then
    echo "This script requires root privileges. Please run as root or with sudo."
    exit 1
fi

yay -Sy --noconfirm --needed \
    ark \
    dolphin \
    elephant \
    emacs-wayland \
    ffmpeg \
    gimp \
    git \
    github-cli \
    hypridle \
    neovim \
    plymouth \
    ripgrep \
    socat
