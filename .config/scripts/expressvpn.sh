#!/bin/sh

isactive="$(sudo systemctl is-active expressvpn.service)"

if [ "$isactive" = "inactive" ]; then
        sudo systemctl start expressvpn.service
        dunstify -a "vpnEnable" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-network-wireless.svg -r "991056" "ExpressVPND Enabled"
        sleep 3
        expressvpn connect "USA - New York"
else
        expressvpn disconnect
        sudo systemctl stop expressvpn.service
        dunstify -a "vpnEnable" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-network-wireless-disconnected.svg -r "991056" "ExpressVPND Disabled"
fi
