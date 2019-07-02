PATH="~/bin:$PATH"

export EDITOR=/usr/bin/emacsclient
export TERMINAL=/usr/bin/terminator

PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$HOME/.gem

export SSH_ASKPASS=ksshaskpass
