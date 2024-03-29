if status is-interactive
    # Commands to run in interactive sessions can go here
end

# PATH
fish_add_path -p ~/.bin
fish_add_path -p ~/.local/share/nvm/v20.11.1/bin
fish_add_path -p ~/.config/emacs/bin
fish_add_path -p ~/src/flutter/bin

# Aliases
alias alacritty="alacritty --config-file ~/.config/i3/alacritty/alacritty.toml"
alias dotdrop='dotdrop --cfg=~/.dotfiles/config.yaml'
alias nv=nvim

{%@@ if profile == "cz-work" @@%}
# Skotty
eval $(skotty ssh env)
{%@@ endif @@%}
