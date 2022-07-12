#!/bin/bash

set -e

script_dir=$(dirname $(realpath $0))
. ${script_dir}/../utils.sh

INCLUDE_32BIT=y ${script_dir}/amd-graphics.sh

step "Install 32-bit deps"
sudo xbps-install -y libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit

step "Install steam"
sudo xbps-install -y steam
