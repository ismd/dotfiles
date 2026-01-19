#!/usr/bin/env bash

set -euo pipefail

gotroot=$(sh -c "sudo -vn" 2>&1 || true)

if [[ "$gotroot" =~ "password" ]]; then
    echo "Sudo access is required to run this script. Authorize sudo and try again."
    exit 1
fi

yay -S --noconfirm --needed \
    7zip \
    ark \
    avahi \
    bind \
    bitwarden-desktop \
    caido-desktop \
    calf \
    cmake \
    discord \
    dms-shell-git \
    docker \
    docker-buildx \
    docker-compose \
    docker-credential-secretservice \
    dolphin \
    easyeffects \
    easytag \
    elephant \
    emacs-wayland \
    evince \
    eza \
    fd \
    ffmpeg \
    ffmpegthumbnailer \
    ffuf \
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
    k9s \
    kubectl \
    libvips \
    libreoffice-still \
    libvterm \
    libtool \
    lsp-plugins-lv2 \
    mc \
    mediainfo \
    neovim \
    nftables \
    nmap \
    noto-fonts-emoji \
    nss-mdns \
    openbsd-netcat \
    openlens-bin \
    pavucontrol \
    perl-image-exiftool \
    plymouth \
    podman-desktop \
    python-pywal \
    remmina \
    ripgrep \
    socat \
    swww \
    viewnior \
    quickshell-git \
    zoom
