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
    aria2 \
    ark \
    avahi \
    bash-language-server \
    bind \
    bitwarden-desktop \
    caido-desktop \
    calf \
    cmake \
    cups-pk-helper \
    direnv \
    discord \
    dms-shell-bin \
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
    gopls \
    hydra \
    hypridle \
    hyprpolkitagent \
    hyprsunset \
    i2c-tools \
    imagemagick \
    imhex-bin \
    inetutils \
    k9s \
    kdeconnect \
    kimageformats \
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
    pyright \
    python-beautifulsoup4 \
    python-pip \
    python-pylint \
    python-pywal \
    qemu-full \
    qt6ct-kde \
    quickshell-git \
    rbw \
    remmina \
    ripgrep \
    socat \
    sshfs \
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
