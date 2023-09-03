#!/bin/sh
# powermenu to use with wofi in hyprland with waybar

#option1="  lock"
#option2="  logout"
#option3="  reboot"
#option4="  power off"

#options="$option1\n"
#options="$options$option2\n"
#options="$options$option3\n$option4"

#choice=$(echo -e "$options" | wofi -dmenu -l 4 -width 30 -p "Powermenu") 

#case $choice in
#	$option1)
#		swaylock ;;
#	$option2)
#		hyprctl dispatch exit ;;
#	$option3)
#		systemctl reboot ;;
#	$option4)
#		systemctl poweroff ;;
#esac 

lock=" lock"
suspend="󰤄 suspend"
logout=" logout"
reboot="  reboot"
shutdown="  shutdown" 

entries="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

#selected=$(echo -e $entries | wofi --width 25 --height 210 --dmenu -p "Powermenu")
selected=$(echo -e $entries | fuzzel --dmenu -l 5 -p "Powermenu ")

case $selected in
  $logout)
    hyprctl dispatch exit ;;
  $lock)
	/home/daniel/.dotfiles/scripts/swaylocker.sh ;;
  $suspend)
    exec systemctl suspend ;;
  $reboot)
    exec systemctl reboot ;;
  $shutdown)
    exec systemctl poweroff ;;
esac