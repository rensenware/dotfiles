#!/bin/sh

isactive="$(nmcli r | tail -n 1 | cut -d\  -f3)"

if [ "$isactive" = "disabled" ]; then
        dunstify -a "toggleNetwork" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-network-wireless.svg -r "991057" "Network Enabled"
        nmcli r all on
else
        dunstify -a "toggleNetwork" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-network-wireless-disconnected.svg -r "991057" "Network Disabled"
        nmcli r all off
fi
