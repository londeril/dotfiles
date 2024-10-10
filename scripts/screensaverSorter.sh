#!/bin/bash
# this script will sort new ScreensaverPics into landscape and portrait directories for Viper and but all pics into the screensaverpics directory

# find all landscape pics and sort them into the right directory
find /run/media/daniel/CryptStore/ScreensaverStaging/ -type f | while read -r file; do
  dimensions=$(identify -format "%w %h" "$file")
  width=$(echo $dimensions | cut -d' ' -f1)
  height=$(echo $dimensions | cut -d' ' -f2)
  if [ "$width" -gt "$height" ]; then
    cp "$file" /home/daniel/Pictures/LandscapeSaver
    echo "sorting $file into landscape pics"
  fi
done
# find all portrait pics and sort them into the right directory
find /run/media/daniel/CryptStore/ScreensaverStaging/ -type f | while read -r file; do
  dimensions=$(identify -format "%w %h" "$file")
  width=$(echo $dimensions | cut -d' ' -f1)
  height=$(echo $dimensions | cut -d' ' -f2)
  if [ "$height" -gt "$width" ]; then
    cp "$file" /home/daniel/Pictures/PortraitSaver
    echo "sorting $file into portrait pics"
  fi
done

# copy all pics to the screensaverpics directory
echo "copying all pics to screensaverpics"
cp /run/media/daniel/CryptStore/ScreensaverStaging/* /home/daniel/Pictures/ScreensaverPics/

# empty the staging directory - and I'll not use the variable... rm $PATH/* could go very bad very fast...
echo "removing pics from staging directory"
rm /run/media/daniel/CryptStore/ScreensaverStaging/*
