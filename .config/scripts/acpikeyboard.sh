#!/bin/sh

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
export XAUTHORITY="/home/rensenware/.Xauthority"
export XDG_RUNTIME_DIR="/run/user/1000"
export DISPLAY="$(xauth -f /home/rensenware/.Xauthority list | cut -d\  -f1 | cut -d\x -f2)"

/home/rensenware/.config/scripts/keylayout.sh
/home/rensenware/.config/scripts/notifykeyboard.sh
/home/rensenware/.config/scripts/layout.sh --update
