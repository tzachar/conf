#!/usr/bin/zsh

export GDK_SCALE=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export XKBLAYOUT=us,il

# 1024 * 192
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Xft/DPI': <196608>}"

xrdb -merge ~/.Xresources
eval `ssh-agent -s`
#ssh-add
# unity-settings-daemon&
xscreensaver &
# xbindkeys&
exec ratpoison
# exec awesome
