#!/usr/bin/env bash

set -euo pipefail

gotroot=$(sh -c "sudo -vn" 2>&1 || true)

if [[ "$gotroot" =~ "password" ]]; then
    echo "Sudo access is required to run this script. Authorize sudo and try again."
    exit 1
fi

yay -S --noconfirm --needed \
    ark \
    bind \
    bitwarden-desktop \
    calf \
    cmake \
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
    gobuster \
    hypridle \
    hyprpolkitagent \
    imagemagick \
    inetutils \
    libreoffice-still \
    libvterm \
    libtool \
    lsp-plugins-lv2 \
    mc \
    neovim \
    nftables \
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
