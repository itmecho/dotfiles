#!/bin/sh

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
export MOZ_ENABLE_WAYLAND=1
export SDL_VIDEODRIVER=wayland
export BROWSER=vivaldi-stable

exec Hyprland
