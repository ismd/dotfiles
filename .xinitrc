#!/bin/sh

# environment variables
export BROWSER=/usr/bin/firefox
export TERMINAL=/usr/bin/terminator

# merge in defaults and keymaps

if [ -f /etc/X11/xinit/.Xresources ]; then
    xrdb -merge /etc/X11/xinit/.Xresources
fi

if [ -f /etc/X11/xinit/.Xmodmap ]; then
    xmodmap /etc/X11/xinit/.Xmodmap
fi

if [ -f "$HOME/.Xresources" ]; then
    xrdb -merge "$HOME/.Xresources"
fi

if [ -f "$HOME/.Xmodmap" ]; then
    xmodmap "$HOME/.Xmodmap"
fi

if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -n "$1" ]; then
    session=$1
else
    session="i3"
fi

case $session in
    i3|i3wm           ) exec i3;;
    kde               ) exec startplasma-x11;;
    xfce|xfce4        ) exec startxfce4;;
    # No known session, try to run it as command
    *                 ) exec $1;;
esac
