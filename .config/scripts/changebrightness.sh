#!/bin/sh

if [ "$1" = "up" ]; then
        sudo xbacklight -inc 10
elif [ "$1" = "down" ]; then
        sudo xbacklight -dec 10
fi

/home/rensenware/.config/scripts/brightness.sh
