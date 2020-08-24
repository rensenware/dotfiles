#!/bin/bash

case "$1" in
        ibm/hotkey)
                case "$4" in
                        00001315)
                                sudo -u rensenware /home/rensenware/.config/scripts/acpikeyboard.sh
                        ;;
                esac
        ;;
esac
