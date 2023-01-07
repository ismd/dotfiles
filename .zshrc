# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
# if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
#   source /usr/share/zsh/manjaro-zsh-config
# fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# Path to your oh-my-zsh installation.
if [ -d "/usr/share/oh-my-zsh" ]; then
  export ZSH="/usr/share/oh-my-zsh"
else
    export ZSH="$HOME/.oh-my-zsh"
fi

plugins=(
  dotenv
  kubectl
  nvm
)

zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd eslint prettier typescript

source $ZSH/oh-my-zsh.sh

# Aliases
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"
alias pssh="TERM='xterm-256color' pssh"

autoload -U select-word-style
select-word-style bash

# History
setopt inc_append_history
setopt no_share_history

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set up Node Version Manager
source /usr/share/nvm/init-nvm.sh

# SSH agent
if [ -z "$TMUX" ]; then
  export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
fi
