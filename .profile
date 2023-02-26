#!/usr/bin/env zsh

export PATH="$HOME/bin:$HOME/.dotfiles/bin:$HOME/Yandex.Disk/bin:$HOME/.config/emacs/bin:$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
export EDITOR=ec	# Terminal editor
export VISUAL=ec	# GUI editor
export NODE_OPTIONS="--max-old-space-size=8192"
export ESHELL=/usr/bin/zsh
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export BROWSER=/usr/bin/firefox
export TERM="xterm-256color"
export TERMINAL=/usr/bin/kitty
# https://www.reddit.com/r/linux/comments/72mfv8/psa_for_firefox_users_set_moz_use_xinput21_to/
export MOZ_USE_XINPUT2=1
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export QT_QPA_PLATFORMTHEME=xdgdesktopportal
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
