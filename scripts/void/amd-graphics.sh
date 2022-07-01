#!/bin/bash

set -e

script_dir=$(dirname $(realpath $0))

. ${script_dir}/../utils.sh

REPOS=(void-repo-nonfree)
PACKAGES=(
	mesa-dri
	vulkan-loader
	amdvlk
	mesa-vaapi
	mesa-vdpau
)

if [[ "$INCLUDE_32BIT" == "y" ]]; then
	REPOS+=(void-repo-multilib void-repo-multilib-nonfree)
	for pkg in ${PACKAGES[@]}; do
		PACKAGES+=(${pkg}-32bit)
	done
fi

step "Install repos"
xinstall -y ${REPOS[@]}

step "Sync repos"
xinstall -S

step "Installing graphics drivers"
xinstall -y ${PACKAGES[@]}
