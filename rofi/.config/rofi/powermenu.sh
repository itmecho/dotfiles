#!/bin/sh

options=$(cat <<EOF
Power off
Reboot
Exit bspwm
EOF
)

choice=$(echo "${options}" | rofi -theme $THEME -dmenu -i)

case $choice in
	'Power off')
		sudo shutdown -h now
		;;
	'Reboot')
		sudo reboot
		;;
	'Exit bspwm')
		pkill bspwm
		;;
esac
