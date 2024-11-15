#!/bin/bash
# remove stale monitors - always make sure to bring up the internal screen first!

export HYPRLAND_INSTANCE_SIGNATURE=$(</tmp/hyprland_instance_signature)

hyprctl keyword monitor eDP-1,preferred,auto,1

case "$1" in
disable)
  hyprctl keyword monitor eDP-1,preferred,auto,1
  #hyprctl keyword monitor desc:HP Inc. HP E243i 6CM82505J0,disable
  #hyprctl keyword monitor desc:Samsung Electric Company C34H89x H4ZR302295,disable

  ;;
enable)
  hyprctl keyword monitor eDP-1,disable
  hyprctl keyword monitor desc:HP Inc. HP E243i 6CM82505J0,preferred,0x0,1,transform,1
  hyprctl keyword monitor desc:Samsung Electric Company C34H89x H4ZR302295,3440x1440@100,auto,1
  ;;
*)
  echo default
  ;;
esac
