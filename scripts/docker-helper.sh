#!/bin/bash
# docking helper
# this script will prepare the system to be (un)docked. We don't want to leave too much to autoconfig or chance...

# let's see if the external monitor is connected
if xrandr -q | grep '3440x1440'; then
	OFFICE="true"
else 
	OFFICE="false"
fi

# let's check why we where called
case $1 in
	--dock)
		# the system was docked - fire ob the external displays, disable the internal one, move desktops and reload polybar
		
		# first let's compensate for our own supidity - if there is no external monitor and we where called to dock... well...
		# bail before everything breaks

		if [ $OFFICE == "false" ]; then
			echo "wanted to dock without being docked... silly..."
			exit 1
		fi

		# enable the external monitors
		xrandr --output DP-1-3 --auto --right-of DP-1-2 --output DP-1-2 --auto --rotate left

		# move all desktops from the internal screen to the big screen
		for desktop in $(bspc query -D --names -m eDP-1 | sed 5q); do
    		bspc desktop "$desktop" --to-monitor DP-1-3
  		done

  		# Remove default desktop created by bspwm
  		bspc desktop Desktop --remove

  		# create a desktop on the sidepanel
		bspc monitor DP-1-2 -d A
		
		# all is setup - disbale the internal display
		xrandr --output eDP-1 --off

		# reload polybar
		~/.dotfiles/polybar/launch.sh --shapes
		;;
	--undock)
		# the system is currently docked but we want to unplug the dock.
		# move desktops to internal display, disable and remove monitors und reload polybar
		
		# first let's compensate for our own supidity - if there is no external monitor and we where called to undock... well...
		# there's nothing to do really... 

		if [ $OFFICE == "false" ]; then
			echo "wanted to undock without being docked first... silly..."
			exit 1
		fi

		# enable internal screen
		xrandr --output eDP-1 --auto

		# move all desktops from the big screen to the internal screen
		for desktop in $(bspc query -D --names -m DP-1-3 | sed 5q); do
    		bspc desktop "$desktop" --to-monitor eDP-1
  		done

  		# Remove default desktop created by bspwm
  		bspc desktop Desktop --remove

  		# remove the sidepanel monitor - not sure what will happen to the windows on it... needs testing
		bspc monitor DP-1-2 -r

		# disable external screens
		xrandr --output DP-1-2 --off --output DP-1-3 --off
		;;
	*)
		echo "usage: --dock --undock"
		;;
esac