#!/bin/bash
# docking helper
# this script will prepare the system to be (un)docked. We don't want to leave too much to autoconfig or chance...

# let's see if the external monitor is connected
if xrandr -q | grep '3440x1440'; then
	OFFICE="true"
else 
	OFFICE="false"
fi

echo $OFFICE

# let's check why we where called
case $1 in
	--dock)
		# the system was docked - fire ob the external displays, disable the internal one, move desktops and reload polybar
		
		# first let's compensate for our own supidity - if there is no external monitor and we where called to dock... well...
		# bail before everything breaks

		if [ $OFFICE == "false" ]; then
			echo -u critical -t 0 "Not at the Office?" "wanted to dock without being anywhere near a dock... which is... silly..."
			exit 1
		fi

		# enable the external monitors
		xrandr --output DP-1-3 --auto --right-of DP-1-2 --output DP-1-2 --auto --rotate left

		# move all desktops from the internal screen to the big screen
		for desktop in $(bspc query -D --names -m eDP-1 | sed 5q); do
    		bspc desktop "$desktop" --to-monitor DP-1-3
  		done

  		# Remove default desktop created by bspwm on DP-1-3
  		bspc desktop Desktop --remove

  		# create a desktop on the sidepanel
		bspc monitor DP-1-2 -d A

		# Remove default desktop created by bspwm on DP-1-2
  		bspc desktop Desktop --remove

		# if we are in the office, chances are that we are running the G815 keyboard - fix the rainbow wave...
		g815-led -a 0080ff
		
		# all is setup - disbale the internal display
		xrandr --output eDP-1 --off

		# reload polybar
		~/.dotfiles/polybar/launch.sh --shapes

		# make sure we don't have "Deskop" desktops
  		#bspc monitor DP-1-3 -d 1 2 3 4 5 6 7 8 9 10 

  		# make bspwm reload it's config
  		bspc wm -r

  		# since we are docked and we no longer rely on microsoft share point B$, we want to mount the local file share
  		# this will take a while... and listen...
  		pkexec mount -t cifs -o credentials=/home/daniel/.smbcreds_ecm,uid=1000,gid=1000,dir_mode=0755,file_mode=0755,noserverino //int.ecmacom.ch/data /mnt/ecm-data

		;;
	--undock)
		# the system is currently docked but we want to unplug the dock.
		# move desktops to internal display, disable and remove monitors und reload polybar
			
		# first let's compensate for our own supidity - if there is no external monitor and we where called to undock... well...
		# there's nothing to do really... 

		if [ $OFFICE == "false" ]; then
			notify-send -u critical -t 0 "Silly me" "wanted to undock without being docked first... silly..."
			exit 1
		fi

		# and while we are at it... we are most likely editing some file stored on a network share... OnlyOffice is the proccess to be concerned about here...
		if pidof soffice.bin; then
			notify-send -u critical -t 0 "Are you sure?" "LibreOffice is open - you most likely have files open on a network share... Close it and try again"
			exit 1
		fi

		# unmount network share
		pkexec umount /mnt/ecm-data

		# check if network drives are still mounted - if they are abort
		if mount | grep 'ecm-data'; then
			notify-send -u critical -t 0 "Netshare Mounted" "will not undock with mounted network shares - unmount them!"
		fi
		
		# enable internal screen
		xrandr --output eDP-1 --auto

		# move all desktops from the big screen to the internal screen
		for desktop in $(bspc query -D --names -m DP-1-3 | sed 5q); do
    		bspc desktop "$desktop" --to-monitor eDP-1
  		done

  		# move all windows from desktop A (sidepanel) to desktop 9
  		for node in $(bspc query -N -d A); do
  			bspc node $node -d 9
  		done

  		# Remove default desktop created by bspwm
  		bspc desktop Desktop --remove

  		# remove the sidepanel monitor - not sure what will happen to the windows on it... needs testing
		bspc monitor DP-1-2 -r

		# disable external screens
		xrandr --output DP-1-2 --off --output DP-1-3 --off

		# notify the user that it's now time to unplug the monitor
		notify-send -u critical -t 0 "Unplug the monitor within the next 10 seconds"
		sleep 10

		# reload polybar
		~/.dotfiles/polybar/launch.sh --shapes

		# make sure we don't have "Deskop" desktops
  		#bspc monitor eDP-1 -d 1 2 3 4 5 6 7 8 9 10 

  		# make bspwm reload it's config
  		bspc wm -r

		;;
	*)
		echo "usage: --dock --undock"
		;;
esac