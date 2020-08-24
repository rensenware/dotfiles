#!/bin/sh

case "$1" in
        "--up")
                pamixer -i 5 
                /home/rensenware/.config/scripts/soundnotif.sh
                ;;
        "--down")
                pamixer -d 5 
                /home/rensenware/.config/scripts/soundnotif.sh
                ;;
        "--toggle")
                pamixer -t 
                /home/rensenware/.config/scripts/soundnotif.sh
                ;;
        "--mic")
                pamixer --source 1 -t 
                /home/rensenware/.config/scripts/micnotif.sh
                ;;
esac
