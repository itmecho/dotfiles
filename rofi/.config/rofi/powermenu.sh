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
		systemctl poweroff
		;;
	'Reboot')
		systemctl poweroff
		;;
	'Exit bspwm')
		systemctl poweroff
		;;
esac
