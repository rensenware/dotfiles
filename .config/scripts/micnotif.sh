#!/bin/sh

if [ "$(pamixer --get-mute --source 1)" = "false" ]; then
	status="change"
else
	status="muted"
fi

case "$status" in
	"muted")
		dunstify -a "changeVolume" -i /usr/share/icons/Papirus-Dark/48x48/status/microphone-sensitivity-muted.svg -r "991055" "Muted" ;;
	"change")
		if [ "$(pamixer --get-volume --source 1)" -gt "65" ]; then
			dunstify -a "changeVolume" -i /usr/share/icons/Papirus-Dark/48x48/status/microphone-sensitivity-high.svg -r "991055" "$(echo "Volume: ""$(pamixer --get-volume --source 1)""%")" 
		elif [ "$(pamixer --get-volume --source 1)" -gt "30" ]; then
			dunstify -a "changeVolume" -i /usr/share/icons/Papirus-Dark/48x48/status/microphone-sensitivity-medium.svg -r "991055" "$(echo "Volume: ""$(pamixer --get-volume --source 1)""%")"
		else
			dunstify -a "changeVolume" -i /usr/share/icons/Papirus-Dark/48x48/status/microphone-sensitivity-low.svg -r "991055" "$(echo "Volume: ""$(pamixer --get-volume --source 1)""%")"
		fi ;;
esac
