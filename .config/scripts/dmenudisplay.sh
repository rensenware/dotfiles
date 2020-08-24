#!/bin/zsh

CHOICES="disconnect\nextend\nclone" # Separate each display option with \n
DMENU="dmenu -p Display"

choice=$(echo "disconnect\nclone\nextend left\nextend right\nexternal only" | dmenu -p Display)

case "$choice" in
        "disconnect")
                dunstify -a "notifyMonitor" -i /usr/share/icons/Papirus-Dark/48x48/devices/display.svg -r "991059" "Disconnected Display"
                xrandr --output "eDP-1" --auto && xrandr --output "HDMI-2" --off
                /home/rensenware/.config/polybar/launch.sh
                /home/rensenware/.fehbg
                ;;
        "extend right")
                dunstify -a "notifyMonitor" -i /usr/share/icons/Papirus-Dark/48x48/devices/display.svg -r "991059" "Extended Display"
                xrandr --output "eDP-1" --auto && xrandr --output "HDMI-2" --auto --right-of "eDP-1"
                /home/rensenware/.config/polybar/launch.sh
                /home/rensenware/.fehbg
                ;;
        "extend left")
                dunstify -a "notifyMonitor" -i /usr/share/icons/Papirus-Dark/48x48/devices/display.svg -r "991059" "Extended Display"
                xrandr --output "eDP-1" --auto && xrandr --output "HDMI-2" --auto --left-of "eDP-1"
                /home/rensenware/.config/polybar/launch.sh
                /home/rensenware/.fehbg
                ;;
        "clone")
                dunstify -a "notifyMonitor" -i /usr/share/icons/Papirus-Dark/48x48/devices/display.svg -r "991059" "Cloned Display"
                xrandr --output "eDP-1" --auto && xrandr --output "HDMI-2" --auto --same-as "eDP-1"
                /home/rensenware/.config/polybar/launch.sh
                /home/rensenware/.fehbg
                ;;
        "external only")
                dunstify -a "notifyMonitor" -i /usr/share/icons/Papirus-Dark/48x48/devices/display.svg -r "991059" "Switched Display"
                xrandr --output "HDMI-2" --auto && xrandr --output "eDP-1" --off
                /home/rensenware/.config/polybar/launch.sh
                /home/rensenware/.fehbg
esac
