#!/bin/bash

PICTURE=$(find /home/daniel/Pictures/LandscapeSaver/ -type f | shuf -n 1)
echo $PICTURE
