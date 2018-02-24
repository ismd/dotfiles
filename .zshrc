HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -e

zstyle :compinstall filename '~/.zshrc'

autoload -U compinit promptinit select-word-style
compinit
promptinit
select-word-style bash

prompt adam2

setopt completealiases
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

DIRSTACKFILE="$HOME/.zsh_dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
#  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus

export PERL_LOCAL_LIB_ROOT="/home/ismd/perl5:$PERL_LOCAL_LIB_ROOT";
export PERL_MB_OPT="--install_base "/home/ismd/perl5"";
export PERL_MM_OPT="INSTALL_BASE=/home/ismd/perl5";
export PERL5LIB="/home/ismd/perl5/lib/perl5:$PERL5LIB";
export PATH="/home/ismd/perl5/bin:$PATH";

svn() {
    if [ "$1" = icdiff ]; then
        shift
        set -- diff --diff-cmd icdiff "$@"
    fi

    command svn "$@"
}
