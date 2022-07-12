#!/bin/bash

cat <<EOF>>
============================================================
	This script installs XOrg and all the other programs
	I use as part of a full bspwm environment. It also
	installs a package from void-packages for gnome polkit
============================================================

Press Enter to continue or ^C to abort...
EOF

read nothing

set -e

script_dir=$(dirname $(realpath $0))
. ${script_dir}/../utils.sh

FONTS=(
	noto-sans
	ttf-opensans
)
UTILS=(
	bat
	fd
	fish-shell
	fzf
	gnupg2
	lsd
	pipewire
	ripgrep
	starship
	stow
	pinentry-gnome
	playerctl
	xtools
)
X_PKGS=(
	setxkbmap
	xclip
	xf86-video-amdgpu
	xorg-minimal
	xrandr
	xdg-utils
)
APPLICATIONS=(
	barrier-gui
	docker
	dunst
	ffmpeg
	firefox
	kitty
	lxappearance
	nitrogen
	pavucontrol
	picom
)
XBPS_SRC_PKGS=(
	discord
	polkit-gnome
	slack
	spotify
)

step "Install packages"
sudo xbps-install -Sy \
	${X_PKGS[@]} \
	${UTILS[@]} \
	${FONTS[@]} \
	${APPLICATIONS[@]}

# xbps-src installs
(
	test -d $HOME/src/void-packages || {
		step "Clone void-packages"
		mkdir -p $HOME/src
		git clone --depth 1 https://github.com/void-linux/void-packages $HOME/src/void-packages
	}

	step "Initialise xbps-src"
	cd $HOME/src/void-packages
	./xbps-src binary-bootstrap

	for pkg in ${XBPS_SRC_PKGS[@]}; do
		step "Build ${pkg}"
		./xbps-src pkg ${pkg}

		step "Install ${pkg}"
		sudo xbps-install --repo hostdir/binpkgs ${pkg}
	done
)
