PATH="$HOME/bin:$PATH"

export EDITOR=/usr/bin/emacsclient
export TERMINAL=/usr/bin/terminator
export BROWSER=/usr/bin/firefox

PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$HOME/.gem
