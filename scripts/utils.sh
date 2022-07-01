#!/bin/bash

function step() {
	echo -e "\e[01m==> $@\e[00m"
}

function is_installed() {
	command -v $1 &>/dev/null
}

function xinstall() {
	sudo xbps-install $@
}
