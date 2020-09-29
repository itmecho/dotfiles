#!/bin/sh

if nmcli c show --active | grep -q "Boomi Flow"; then
    echo '%{F#50fa7b} 旅 %{F-}'
else
    echo '%{F#ffb86c} 旅 %{F-}'
fi
