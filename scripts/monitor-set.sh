#!/bin/bash
# remove stale monitors - always make sure to bring up the internal screen first!

HYPRLAND_INSTANCE_SIGNATURE=$(</tmp/hyprland_instance_signature)

hyprctl keyword monitor eDP-1,preferred,auto,1

hyprctl keyword monitor desc:HP Inc. HP E243i 6CM82505J0,disable >/dev/null
hyprctl keyword monitor desc:Samsung Electric Company C34H89x H4ZR302295,disable >/dev/null
