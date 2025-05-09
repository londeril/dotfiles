#!/bin/sh
# powermenu to use with wofi in hyprland with waybar

lock="lock"
suspend="suspend"
logout="logout"
reboot="reboot"
shutdown="shutdown"
dock="dock"
undock="undock"
dock-home="dock-home"
undock-home="undock-home"

#  󰤄        󱐥  󰚦

entries="$lock\n$suspend\n$reboot\n$shutdown\n$logout\n$dock\n$undock\n$dock-home\n$undock-home"

#selected=$(echo -e $entries | wofi --width 25 --height 210 --dmenu -p "Powermenu")
#selected=$(echo -e $entries | fuzzel --dmenu -l 7 -p "Powermenu ")
selected=$(echo -e $entries | dmenu --d -l 9 -p "Powermenu ")

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
$dock-home)
  /home/daniel/.dotfiles/scripts/docker-helper.sh --dock-home
  ;;
$undock-home)
  /home/daniel/.dotfiles/scripts/docker-helper.sh --undock-home
  ;;

esac
