#!/bin/sh

xrandr --dpi 132 &
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Disable While Typing Enabled" 0 &
setxkbmap dvorak -option compose:ralt -option caps:swapescape &
xset r rate 300 50 &
picom --config /home/rensenware/.config/picom/config &
/home/rensenware/.fehbg &
/usr/lib/xfce-polkit/xfce-polkit &
dunst &
/home/rensenware/.config/polybar/launch.sh &
