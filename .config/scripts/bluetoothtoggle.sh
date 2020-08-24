#!/bin/sh

isactive="$(sudo systemctl is-active bluetooth.service)"

if [ "$isactive" = "inactive" ]; then
        sudo systemctl start bluetooth.service
        dunstify -a "toggleBluetooth" -i /usr/share/icons/Papirus-Dark/48x48/status/bluetooth.svg -r "991056" "Bluetooth Enabled"
else
        sudo systemctl stop bluetooth.service
        dunstify -a "toggleBluetooth" -i /usr/share/icons/Papirus-Dark/48x48/status/bluetooth-disabled.svg -r "991056" "Bluetooth Disabled"
fi
