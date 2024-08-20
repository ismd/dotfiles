if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

# PATH
fish_add_path -p ~/.bin
fish_add_path -p ~/.local/share/nvm/v20.16.0/bin
fish_add_path -p ~/.config/emacs/bin
fish_add_path -p ~/src/flutter/bin
fish_add_path -p ~/.pub-cache/bin

# Aliases
alias alacritty="alacritty --config-file ~/.config/i3/alacritty/alacritty.toml"
alias dotdrop='~/.dotfiles/dotdrop.sh --cfg=~/.dotfiles/config.yaml'
alias nv=nvim
