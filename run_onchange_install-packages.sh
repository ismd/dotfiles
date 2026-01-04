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
    calf \
    dms-shell-git \
    dolphin \
    easyeffects \
    elephant \
    emacs-wayland \
    eza \
    ffmpeg \
    fwupd \
    gimp \
    git \
    github-cli \
    hypridle \
    hyprpolkitagent \
    imagemagick \
    inetutils \
    libreoffice-still \
    lsp-plugins-lv2 \
    neovim \
    noto-fonts-emoji \
    pavucontrol \
    plymouth \
    python-pywal \
    ripgrep \
    socat \
    swww \
    viewnior \
    quickshell-git \
    zoom
