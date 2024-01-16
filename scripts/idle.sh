#!/bin/bash

# get some status vars
# check if we run on AC or BAT power
ACSTATUS=`cat /sys/class/power_supply/AC/online`
# Check if Audio is playing or not
AUDIO=`pactl list | grep RUNNING && echo 1 || echo 0`
# check if we are on our cosy home wlan or at the very least in a new with the same subnet...
IP=$(ip a | awk '/inet / && /172\.16\.3\./ {print $2}' | cut -d'/' -f1)
if [[ ! -z "$IP" ]]; then
	HOME=1
else
	HOME=0
fi

case $1 in 
	SCREENSAVER )
		# we where called to display nice pictures of the kids in both screens, happy to comply! but only if we don't play audio and if we are running on AC power
		if [[ $AUDIO == 0 ]] && [[ $ACSTATUS == 1 ]]; then
			/home/daniel/.dotfiles/scripts/screensaver.sh 
			echo "on AC and no Audio - displaying pics"
		fi
		;;
	KILLSAVER )
		# kill screensaver
		killall -15 feh
		echo "killing screensaver on input"
		;;
	BATSCREEN )
		# we where called to turn off the screen - let's do that IF we run on battery AND no sound is playing
		if [[ $ACSTATUS == 0 ]] && [[ $AUDIO == 0 ]]; then
			hyprctl dispatch dpms off
			echo "on Battery and no Audio - display off"
		fi
		;;
	BATLOCK )
		# we where called to lock the session with the on battery timer - so let's see if we are on battery. we'll lock on battery IF no audio is playing.
		# also we won't lock if we are in our own cozy WLAN - we've entered the password enough times today...
		if [[ $AUDIO == 0 ]] && [[ $ACSTATUS == 0 ]] && [[ $HOME == 0 ]]; then
			/home/daniel/.dotfiles/scripts/swaylocker.sh &
			echo "on Battery and no Audio and not at home - lock"
		fi
		;;
	BATSUSPEND )
		# we where called to suspend the machine - let's do that IF we run on battery
		if [[ $ACSTATUS == 0 ]] && [[ $AUDIO == 0 ]]; then
			/home/daniel/.dotfiles/scripts/swaylocker.sh &
   			sleep 3
    		systemctl suspend
			echo "on Battery and no Audio - suspend"
		fi
		;;
	ACLOCK )
		# we where called to lock the session with the AC tier - so let's do this if we are on AC AND no audio is playing
		if [[ $AUDIO == 0 ]] && [[ $ACSTATUS == 1 ]]; then
			/home/daniel/.dotfiles/scripts/swaylocker.sh &
			echo "on AC and no Audio - suspend"
		fi
		;;
	BATDIM )
		# we where called to dim the screen - we'll do that if we don't run an AC and no Audio is playing. but we'll fist need to get the current brightness
		brightnessctl get > /tmp/brightness
		if [[ $ACSTATUS == 0 ]] && [[ $AUDIO == 0 ]]; then
			brightnessctl set 4800 >/dev/null
			echo "on Battery and no Audio - dim screen"
		fi
		;;
	BATUNDIM )
		# restore brightness
		BRIGHTNESS=`cat /tmp/brightness`
		brightnessctl set $BRIGHTNESS >/dev/null
		echo "input registered undimming"
		;;
esac	


#swayidle -w \
#                timeout 120 'hyprctl dispatch dpms off' \
#                timeout 130 '/home/daniel/.dotfiles/scripts/swaylocker.sh' \
#                timeout 300 'systemctl suspend'
