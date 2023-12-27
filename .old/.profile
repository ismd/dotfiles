#!/usr/bin/env zsh

export PATH="$HOME/bin:$HOME/.dotfiles/bin:$HOME/Nextcloud/bin:$HOME/Yandex.Disk/bin:$HOME/.config/emacs/bin:$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH:$HOME/src/flutter/bin"
export EDITOR=ec # Terminal editor
export VISUAL=ec # GUI editor
export NODE_OPTIONS="--max-old-space-size=8192"
export ESHELL=/usr/bin/zsh
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export BROWSER=/usr/bin/brave
export TERM="xterm-256color"
export TERMINAL=/usr/bin/kitty
# https://www.reddit.com/r/linux/comments/72mfv8/psa_for_firefox_users_set_moz_use_xinput21_to/
export MOZ_USE_XINPUT2=1
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# export QT_QPA_PLATFORMTHEME=xdgdesktopportal
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_AUTO_SCREEN_SCALE_FACTOR=1
# export QT_SCREEN_SCALE_FACTORS="eDP-1=1;HDMI-1=1;DP-1=1;DP-2=1;DP-3=1.25;DP-4=1;"