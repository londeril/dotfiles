#!/bin/sh
# Waybar launcher 
#
# launch waybar with custom settings. kill it if it's already up
if pgrep -x waybar > /dev/null
        then killall -15 waybar
        waybar & 
else 
        waybar & 
fi
