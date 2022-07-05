#!/bin/sh

id=$1
class=$2
instance=$3

toDesktop() {
	echo "desktop=$1 follow=on "
}

float() {
	echo "state=floating "
}

handleMissingClass() {
	comm=$(ps -p "$(xdo pid $id)" -o comm= 2>/dev/null)
	case $comm in
		(spotify) toDesktop 4 ;;
	esac
}

case $class in
	Firefox|firefox|Brave-Browser)
		toDesktop 1
		test "$instance" = "Toolkit" && float
		;;
	Alacritty|kitty) toDesktop 2 ;;
	Slack) toDesktop 3 ;;
	pinentry-gtk-2) float ;;
	Peek) float ;;
	1password) float ;;
	"") handleMissingClass ;;
esac
