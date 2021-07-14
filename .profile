export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$HOME/bin:$HOME/.emacs.d/bin:$HOME/.local/bin:$GEM_HOME/bin:$PATH"

export EDITOR=/usr/bin/emacsclient
export BROWSER=/usr/bin/firefox
export TERMINAL=/usr/bin/kitty
export NODE_OPTIONS=--max-old-space-size=8192
export SHELL=/bin/zsh
export ESHELL=/bin/zsh
