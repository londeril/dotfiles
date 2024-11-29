#!/bin/sh
# powermenu to use with wofi in hyprland with waybar

lock="lock"
suspend="suspend"
logout="logout"
reboot="reboot"
shutdown="shutdown"
dock="dock"
undock="undock"

#  󰤄        󱐥  󰚦

entries="$lock\n$suspend\n$reboot\n$shutdown\n$logout\n$dock\n$undock"

#selected=$(echo -e $entries | wofi --width 25 --height 210 --dmenu -p "Powermenu")
#selected=$(echo -e $entries | fuzzel --dmenu -l 7 -p "Powermenu ")
selected=$(echo -e $entries | dmenu --d -l 7 -p "Powermenu ")

case $selected in
$lock)
  #/home/daniel/.dotfiles/scripts/swaylocker.sh &
  loginctl lock-session
  ;;
$suspend)
  #/home/daniel/.dotfiles/scripts/swaylocker.sh &
  /home/daniel/.dotfiles/scripts/howdy-checker.sh set_suspend_suspend
  ;;
$reboot)
  systemctl reboot
  ;;
$shutdown)
  systemctl poweroff
  ;;
$logout)
  hyprctl dispatch exit
  ;;
$dock)
  /home/daniel/.dotfiles/scripts/docker-helper.sh --dock
  ;;
$undock)
  /home/daniel/.dotfiles/scripts/docker-helper.sh --undock
  ;;

esac
