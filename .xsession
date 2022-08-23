#!/usr/bin/zsh

export GDK_SCALE=2
export QT_AUTO_SCREEN_SCALE_FACTOR=1

xrdb -merge ~/.Xresources
#eval `ssh-agent -s`
#ssh-add
# unity-settings-daemon&
# xscreensaver&
# xbindkeys&
exec ratpoison
# exec awesome
