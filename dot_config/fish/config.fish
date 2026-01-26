function fish_greeting
    fortune | cowsay | lolcat
end

if status is-interactive
    set -U fish_greeting
end

# PATH
fish_add_path -p ~/.bin
fish_add_path -p ~/.local/bin
fish_add_path -p ~/.config/emacs/bin
fish_add_path -p ~/src/flutter/bin
fish_add_path -p ~/.pub-cache/bin

# Abbreviations
abbr -a aa arc add
abbr -a aci arc commit
abbr -a aco arc checkout
abbr -a acob arc checkout -b
abbr -a ad arc diff
abbr -a ap arc pull
abbr -a apush arc push
abbr -a as arc status

abbr -a ga git add
abbr -a gci git commit
abbr -a gco git checkout
abbr -a gcob git checkout -b
abbr -a gd git diff
abbr -a gp git pull
abbr -a gpush git push
abbr -a gs git status

abbr -a i yay -S
abbr -a k kubectl
abbr -a p python
abbr -a s yay -Ss

# Aliases
alias b bluetoothctl
alias c 'set dir (command ls -lah | fzf | awk "{print \$9}"); and cd $dir'
alias cat bat
alias claude="~/.claude/local/claude"
alias guitar-pro 'wine ~/.wine/drive_c/Program\ Files/Arobas\ Music/Guitar\ Pro\ 8/GuitarPro.exe'
alias nv nvim
alias pk 'set pid (ps -aux | fzf | awk "{print \$2}"); and kill -9 $pid'

# eza
set EZA_STANDARD_OPTIONS --group --header --group-directories-first --icons --hyperlink
alias llt 'eza $EZA_STANDARD_OPTIONS --tree'

# fzf
set FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --margin 1,2'
fzf --fish | source

# nvm
set -U nvm_default_version 24
set -U nvm_data ~/.nvm

# Secrets
if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

# direnv
direnv hook fish | source

# Kill word
bind alt-d 'commandline -f kill-word'
bind alt-backspace 'commandline -f backward-kill-word'

# Kitten aliases
alias d="kitten diff"
