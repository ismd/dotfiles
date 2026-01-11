#!/usr/bin/env bash

set -euo pipefail

gotroot=$(sh -c "sudo -vn" 2>&1 || true)

if [[ "$gotroot" =~ "password" ]]; then
    echo "Sudo access is required to run this script. Authorize sudo and try again."
    exit 1
fi

yay -S --noconfirm --needed \
    ark \
    avahi \
    bind \
    bitwarden-desktop \
    calf \
    cmake \
    dms-shell-git \
    docker \
    docker-buildx \
    docker-compose \
    dolphin \
    easyeffects \
    easytag \
    elephant \
    emacs-wayland \
    evince \
    eza \
    ffmpeg \
    fwupd \
    gimp \
    git \
    github-cli \
    gobuster \
    hydra \
    hypridle \
    hyprpolkitagent \
    imagemagick \
    inetutils \
    kubectl \
    libreoffice-still \
    libvterm \
    libtool \
    lsp-plugins-lv2 \
    mc \
    neovim \
    nftables \
    nmap \
    noto-fonts-emoji \
    nss-mdns \
    openbsd-netcat \
    pavucontrol \
    plymouth \
    podman-desktop \
    python-pywal \
    ripgrep \
    socat \
    swww \
    viewnior \
    quickshell-git \
    zoom
