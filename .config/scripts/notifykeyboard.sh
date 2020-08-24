#!/bin/sh

layout=$(setxkbmap -query | grep layout | tail -c 3 | head -c 2)
dv="ak"
us="us"

if [ "$layout" = "$dv" ]; then
	dunstify -a "changeLayout" -i /usr/share/icons/Papirus-Dark/48x48/devices/input-keyboard.svg -r "991052" "Layout: Dvorak"
else
	dunstify -a "changeLayout" -i /usr/share/icons/Papirus-Dark/48x48/devices/input-keyboard.svg -r "991052" "Layout: US"
fi
