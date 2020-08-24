#!/bin/sh

status=$(xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Enabled" | tail -c 2 | head -c 1)

if [ "$status" = 1 ]; then
	xinput disable "SynPS/2 Synaptics TouchPad"
else
	xinput enable "SynPS/2 Synaptics TouchPad"
fi
