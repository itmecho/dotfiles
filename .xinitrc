#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1

xrandr --auto
xrandr --setprovideroutputsource modesetting NVIDIA-0

xrandr --output HDMI-1 --mode 2560x1440 --primary
xrandr --output DP-2-2 --mode 1920x1200 --left-of HDMI-1
xrandr --output eDP-1 --mode 1920x1080 --below HDMI-1

xsetroot -xcf /usr/share/icons/Vanilla-DMZ-AA/cursors/left_ptr 16

xinput set-int-prop "DLL07BF:01 06CB:7A13 Touchpad" "libinput Natural Scrolling Enabled" 8 1
bash -c 'xinput set-prop "DLL07BF:01 06CB:7A13 Touchpad" "libinput Click Method Enabled" {0,1}'

numlockx on

exec bspwm
