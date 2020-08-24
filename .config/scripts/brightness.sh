#!/bin/sh

brightness=$(xbacklight -get)

if [ "$brightness" -gt "85" ]; then
	dunstify -a "changeBrightness" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-full.svg -r "991050" "$(echo "Brightness: ""$(xbacklight -get)""%")"
elif [ "$brightness" -gt "70" ]; then
	dunstify -a "changeBrightness" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-high.svg -r "991050" "$(echo "Brightness: ""$(xbacklight -get)""%")"
elif [ "$brightness" -gt "35" ]; then
	dunstify -a "changeBrightness" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-medium.svg -r "991050" "$(echo "Brightness: ""$(xbacklight -get)""%")"
elif [ "$brightness" -gt "5" ]; then
	dunstify -a "changeBrightness" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-low.svg -r "991050" "$(echo "Brightness: ""$(xbacklight -get)""%")"
else
	dunstify -a "changeBrightness" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-off.svg -r "991050" "$(echo "Brightness: ""$(xbacklight -get)""%")"
fi
