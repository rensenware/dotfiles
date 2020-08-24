#!/bin/sh

if [ "$(pamixer --get-mute)" = "false" ]; then
	status="change"
else
	status="muted"
fi

case "$status" in
	"muted")
		dunstify -a "changeVolume" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-audio-volume-muted.svg -r "991049" "Muted" ;;
	"change")
		if [ "$(pamixer --get-volume)" -gt "65" ]; then
			dunstify -a "changeVolume" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-audio-volume-high.svg -r "991049" "$(echo "Volume: ""$(pamixer --get-volume)""%")" 
		elif [ "$(pamixer --get-volume)" -gt "30" ]; then
			dunstify -a "changeVolume" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-audio-volume-medium.svg -r "991049" "$(echo "Volume: ""$(pamixer --get-volume)""%")"
		else
			dunstify -a "changeVolume" -i /usr/share/icons/Papirus-Dark/48x48/status/notification-audio-volume-low.svg -r "991049" "$(echo "Volume: ""$(pamixer --get-volume)""%")"
		fi ;;
esac
