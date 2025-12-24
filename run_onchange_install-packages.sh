#!/usr/bin/env bash

set -euo pipefail

gotroot=$(sh -c "sudo -vn" 2>&1 || true)

if [[ "$gotroot" =~ "password" ]]; then
    echo "Sudo access is required to run this script. Authorize sudo and try again."
    exit 1
fi

yay -Sy --noconfirm --needed \
    ark \
    bind \
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
    inetutils \
    neovim \
    noto-fonts-emoji \
    plymouth \
    python-pywal \
    ripgrep \
    socat \
    swww
