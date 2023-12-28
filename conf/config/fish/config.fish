if status is-interactive
    # Commands to run in interactive sessions can go here
end

# PATH
fish_add_path -p ~/.bin
fish_add_path -p ~/.local/share/nvm/v20.9.0/bin
fish_add_path -p ~/.config/emacs/bin

# nvim
alias nv=nvim

# dotdrop
alias dotdrop='dotdrop --cfg=~/.dotfiles/config.yaml'

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

{%@@ if profile == "cz-work" @@%}
# Skotty
eval $(skotty ssh env)
{%@@ endif @@%}
