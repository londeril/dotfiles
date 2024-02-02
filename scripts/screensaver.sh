#!/bin/bash
# this script runs feh in fullscreen mode to display screensaverpics on both displays at the office

# let's check on which host we are running
HOSTNAME=`hostname`

if [[ $HOSTNAME == "Nova" ]]; then
	feh --fullscreen --slideshow-delay 7 --auto-zoom --hide-pointer --xinerama-index 0 --randomize /home/daniel/Pictures/ScreensaverPics &
elif [[ $HOSTNAME == "viper" ]]; then
	feh --fullscreen --slideshow-delay 7 --auto-zoom --hide-pointer --xinerama-index 1 --randomize /home/daniel/Pictures/ScreensaverPics &
else 
	# I don't know on which host we are running... better do nothing
	echo "no hostname found"
fi


