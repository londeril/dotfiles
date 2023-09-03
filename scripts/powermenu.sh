#!/bin/sh
# powermenu to use with wofi in hyprland with waybar

lock=" lock"
suspend="󰤄 suspend"
logout=" logout"
reboot=" reboot"
shutdown=" shutdown" 

entries="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

#selected=$(echo -e $entries | wofi --width 25 --height 210 --dmenu -p "Powermenu")
selected=$(echo -e $entries | fuzzel --dmenu -l 5 -p "Powermenu ")

case $selected in
  $logout)
    hyprctl dispatch exit ;;
  $lock)
    /home/daniel/.dotfiles/scripts/swaylocker.sh ;;
  $suspend)
    systemctl suspend ;;
  $reboot)
    systemctl reboot ;;
  $shutdown)
    systemctl poweroff ;;
esac

~/.dotfiles/waybar/launch.sh