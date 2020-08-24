#!/bin/sh

# The famous "get a menu of emojis to copy" script.

# Get user selection via dmenu from emoji file.
chosen=$(cut -d ';' -f1 /home/rensenware/.config/emoji | rofi -dmenu -font "Segoe UI 13" -location 7 -yoffset -29 -width 25 -lines 15 | sed "s/ .*//")

# Exit if none chosen.
[ -z "$chosen" ] && exit

# If you run this command with an argument, it will automatically insert the
# character. Otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
	xdotool type "$chosen"
else
	echo "$chosen" | tr -d '\n' | xsel -b
	notify-send "'$chosen' copied to clipboard." &
fi
