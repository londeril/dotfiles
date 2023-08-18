#!/bin/bash
# this script runs feh in fullscreen mode to display screensaverpics on both displays at the office
feh --fullscreen --slideshow-delay 7 --auto-zoom --hide-pointer --xinerama-index 1 /home/daniel/Pictures/ScreensaverPics &
feh --fullscreen --slideshow-delay 7 --auto-zoom --hide-pointer --xinerama-index 0 /home/daniel/Pictures/ScreensaverPics &