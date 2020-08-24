#!/bin/sh

status=$(xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Enabled" | tail -c 2 | head -c 1)

if [ "$status" = 0 ]; then
	dunstify -a "changeTouchpad" -i /usr/share/icons/Papirus-Dark/48x48/status/input-touchpad-off.svg -r "991051" "Touchpad Disabled"
else
	dunstify -a "changeTouchpad" -i /usr/share/icons/Papirus-Dark/48x48/status/input-touchpad-on.svg -r "991051" "Touchpad Enabled"
fi
