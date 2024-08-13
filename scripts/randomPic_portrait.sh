#!/bin/bash




find ~/Pictures/ScreensaverPics/ -type f | while read -r file; do
  dimensions=$(identify -format "%w %h" "$file")
  width=$(echo $dimensions | cut -d' ' -f1)
  height=$(echo $dimensions | cut -d' ' -f2)
  if [ "$height" -gt "$width" ]; then
    cp "$file" /home/daniel/Pictures/PortraitSaver
    echo "copy pic"
  fi
done 


 # dimensions=$(identify -format "%w %h" "/home/daniel/Pictures/ScreensaverPics/IMG_8203.jpg")
 #echo $dimensions 
 ## width=$(echo $dimensions | cut -d' ' -f1)
 # echo $width
 # height=$(echo $dimensions | cut -d' ' -f2)
 # echo $height
 # if [ "$width" -gt "$height" ]; then
 ##   echo "$file"
 #   echo "file"
 # else
 #	echo "nofile"
 # fi
