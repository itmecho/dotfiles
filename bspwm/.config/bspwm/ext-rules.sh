#!/bin/sh

id=$1
class=$2
instance=$3

function toDesktop() {
	echo "desktop=$1 follow=on "
}

function float() {
	echo "state=floating "
}

function handleMissingClass() {
	comm=$(ps -p "$(xdo pid $id)" -o comm= 2>/dev/null)
	case $comm in
		(spotify) toDesktop 4 ;;
	esac
}

case $class in
	firefox|Brave-Browser) toDesktop 1 ;;
	Alacritty) toDesktop 2 ;;
	Slack) toDesktop 3 ;;
	pinentry-gtk-2) float ;;
	Peek) float ;;
	"") handleMissingClass ;;
esac
