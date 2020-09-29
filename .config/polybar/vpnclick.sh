#!/bin/sh

vpn_id="Boomi Flow"

if nmcli c show --active | grep -q "$vpn_id"; then
    nmcli con down id "$vpn_id"
else
    nmcli con up id "$vpn_id" --ask
fi
