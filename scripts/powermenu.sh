#!/bin/sh
# powermenu to use with wofi in hyprland with waybar

lock="lock"
suspend="suspend"
logout="logout"
reboot="reboot"
shutdown="shutdown" 
#dock="dock"
#undock="undock"

#  󰤄        󱐥  󰚦

entries="$lock\n$suspend\n$reboot\n$shutdown\n$logout"

#selected=$(echo -e $entries | wofi --width 25 --height 210 --dmenu -p "Powermenu")
#selected=$(echo -e $entries | fuzzel --dmenu -l 7 -p "Powermenu ")
selected=$(echo -e $entries | dmenu --d -l 5 -p "Powermenu ")

case $selected in
  $lock)
    #/home/daniel/.dotfiles/scripts/swaylocker.sh &
    loginctl lock-session
    ;;
  $suspend)
    #/home/daniel/.dotfiles/scripts/swaylocker.sh &
    loginctl lock-session
    sleep 3
    systemctl suspend
    ;;
  $reboot)
    systemctl reboot ;;
  $shutdown)
    systemctl poweroff ;;
  $logout)
    hyprctl dispatch exit ;;
esac

#~/.dotfiles/waybar/launch.sh


#$dock)
#    # chances are we messed up... check if there is only the internal screen pressent - if it is... don't dock...
#    monitors=$(hyprctl monitors -j | jq '. | length')
#    if [ "$monitors" -eq 1 ]; then
#        # only one screen present.. please don't disable that...
#        notify-send -u critical -t 0 "There is only one screen... I will not disable the last monitor... bailing"
#    else
#      # disable internal notebook display
#      hyprctl keyword monitor eDP-1,disable
#      # get current workspaces from hyrland
#      workspaces=`hyprctl -j workspaces`
#      # loop through the json data and extract the workspace's ids
#      for item in $(echo "$workspaces" | jq -c '.[] | .id'); do
#        # move each workspace to the big screen
#        hyprctl dispatch moveworkspacetomonitor $item DP-7
#      done
#    fi
#    ;;
##  $undock)
#    # get the internal screen back online 
#    hyprctl keyword monitor eDP-1,prefered,auto,1
#    ;;