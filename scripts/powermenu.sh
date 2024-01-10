#!/bin/sh
# powermenu to use with wofi in hyprland with waybar

lock=" lock"
suspend="󰤄 suspend"
logout=" logout"
reboot=" reboot"
shutdown=" shutdown" 
dock="dock"
undock="undock"

entries="$lock\n$suspend\n$dock\n$undock\n$reboot\n$shutdown\n$logout"

#selected=$(echo -e $entries | wofi --width 25 --height 210 --dmenu -p "Powermenu")
selected=$(echo -e $entries | fuzzel --dmenu -l 5 -p "Powermenu ")

case $selected in
  *)
    # nothing chosen, exiting
    ;;
  $lock)
    /home/daniel/.dotfiles/scripts/swaylocker.sh &
    ;;
  $suspend)
    /home/daniel/.dotfiles/scripts/swaylocker.sh &
    sleep 3
    systemctl suspend
    ;;
  $dock)
    # disable internal notebook display
    hyprctl keyword monitor eDP-1,disable
    # get current workspaces from hyrland
    workspaces=`hyprctl -j workspaces`
    # loop through the json data and extract the workspace's ids
    for item in $(echo "$workspaces" | jq -c '.[] | .id'); do
      # move each workspace to the big screen
      hyprctl dispatch moveworkspacetomonitor $item DP-7
    done
    ;;
  $undock)
    # get the internal screen back online 
    hyprctl keyword monitor eDP-1,prefered,auto,1
    ;;
  $reboot)
    systemctl reboot ;;
  $shutdown)
    systemctl poweroff ;;
  $logout)
    hyprctl dispatch exit ;;
esac

#~/.dotfiles/waybar/launch.sh
