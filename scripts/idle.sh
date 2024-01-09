#!/bin/bash

ACSTATUS=`cat /sys/class/power_supply/AC/online`
echo $ACSTATUS

case $1 in 
	screen )
		# we where called to turn off the screen - let's do that IF we run on battery
		if [[ $ACSTATUS == 0 ]]; then
			hyprctl dispatch dpms off
		fi
		;;
	lock )
		# we where called to lock the session we'll do this regardless of AC status
		~/.dotfiles/scripts/swaylocker.sh
		;;
	suspend )
		# we where called to suspend the machine - let's do that IF we run on battery
		systemctl suspend
		;;
esac


#swayidle -w \
#                timeout 120 'hyprctl dispatch dpms off' \
#                timeout 130 '~/.dotfiles/scripts/swaylocker.sh' \
#                timeout 300 'systemctl suspend'
