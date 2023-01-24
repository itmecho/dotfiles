#!/bin/sh

numlockx on

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/:/var/lib/flatpak/exports/share:/home/iain/.local/share/flatpak/exports/share"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"

xrandr --output DisplayPort-0 --primary --mode 2560x1440 --output DVI-D-0 --left-of DisplayPort-0 --mode 1920x1200 --rotate left

setxkbmap gb

gpg-agent --server --enable-ssh-support &

dbus-run-session bspwm
