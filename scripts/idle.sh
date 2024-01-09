#!/bin/bash

# get some status vars
ACSTATUS=`cat /sys/class/power_supply/AC/online`
AUDIO=`pactl list | grep RUNNING && echo 1 || echo 0`

case $1 in 
	BATSCREEN )
		# we where called to turn off the screen - let's do that IF we run on battery AND no sound is playing
		if [[ $ACSTATUS == 0 ]] && [[ $AUDIO == 0 ]]; then
			hyprctl dispatch dpms off
			echo "on Battery and no Audio - display off"
		fi
		;;
	BATLOCK )
		# we where called to lock the session with the on battery timer - so let's see if we are on battery. we'll lock on battery IF no audio is playing
		if [[ $AUDIO == 0 ]] && [[ $ACSTATUS == 0 ]]; then
			~/.dotfiles/scripts/swaylocker.sh &
			echo "on Battery and no Audio - lock"
		fi
		;;
	BATSUSPEND )
		# we where called to suspend the machine - let's do that IF we run on battery
		if [[ $ACSTATUS == 0 ]] && [[ $AUDIO == 0 ]]; then
			systemctl suspend
			echo "on Battery and no Audio - suspend"
		fi
		;;
	ACLOCK )
		# we where called to lock the session with the AC tier - so let's do this if we are on AC AND no audio is playing
		if [[ $AUDIO == 0 ]] && [[ $ACSTATUS == 1 ]]; then
			~/.dotfiles/scripts/swaylocker.sh &
			echo "on AC and no Audio - suspend"
		fi
		;;
esac


#swayidle -w \
#                timeout 120 'hyprctl dispatch dpms off' \
#                timeout 130 '~/.dotfiles/scripts/swaylocker.sh' \
#                timeout 300 'systemctl suspend'
