export EDITOR="/usr/bin/emacsclient"

PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$HOME/.gem

export SSH_ASKPASS=ksshaskpass
