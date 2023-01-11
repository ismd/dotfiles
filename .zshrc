# Tramp
[[ $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



if [[ -e /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi

if [[ -d "/usr/share/oh-my-zsh" ]]; then
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

# Auto suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set up Node Version Manager
source /usr/share/nvm/init-nvm.sh

# SSH agent
[[ -z "$TMUX" ]] && export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
