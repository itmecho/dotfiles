#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

location=$(/home/iain/bin/whereami)

# Launch bar
case $location in
    "work")
        MONITOR=DP-1-2-2 polybar main &
        MONITOR=HDMI-1-1 polybar secondary &
        ;;
    "home")
        MONITOR=HDMI-1-1 polybar main &
        MONITOR=DP-1-2-2 polybar secondary &
        ;;
    *)
        polybar main &
        ;;
esac

echo "Bars launched..."
