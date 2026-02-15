#!/usr/bin/env bash

set -euo pipefail

gotroot=$(sh -c "sudo -vn" 2>&1 || true)

if [[ "$gotroot" =~ "password" ]]; then
    echo "Sudo access is required to run this script. Authorize sudo and try again."
    exit 1
fi

yay -S --noconfirm --needed \
    7zip \
    adw-gtk-theme \
    ark \
    avahi \
    bash-language-server \
    bind \
    bitwarden-desktop \
    caido-desktop \
    calf \
    cmake \
    direnv \
    discord \
    dms-shell-bin \
    dms-shell-hyprland \
    dnsmasq \
    docker \
    docker-buildx \
    docker-compose \
    docker-credential-secretservice \
    dolphin \
    downgrade \
    easyeffects \
    easytag \
    elephant \
    elephant-bitwarden \
    elephant-calc \
    elephant-desktopapplications \
    elephant-providerlist \
    elephant-symbols \
    elephant-unicode \
    elephant-websearch \
    emacs-wayland \
    evince \
    eza \
    fd \
    ffmpeg \
    ffmpegthumbnailer \
    ffuf \
    fish-lsp \
    fwupd \
    gimp \
    git \
    github-cli \
    gobuster \
    hydra \
    hypridle \
    hyprpolkitagent \
    i2c-tools \
    imagemagick \
    imhex-bin \
    inetutils \
    k9s \
    kubectl \
    libreoffice-still \
    libvips \
    libvirt \
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
    python-pip \
    python-pylint \
    python-pywal \
    qemu-full \
    quickshell \
    rbw \
    remmina \
    ripgrep \
    socat \
    swww \
    tigervnc \
    tlp \
    tlp-pd \
    viewnior \
    vscode-json-languageserver \
    whois \
    xournalpp \
    yaml-language-server \
    zoom
