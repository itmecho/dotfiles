#!/bin/sh

state=$XDG_RUNTIME_DIR/xautolock_state
if [ ! -f ${state} ]; then
	xautolock -enable
	echo 1 > ${state}
fi

if [ $(cat ${state}) -eq 1 ]; then
	echo "%{F#${THEME_GREEN}} %{F-}"
else
	echo "%{F#${THEME_YELLOW}} %{F-}"
fi
