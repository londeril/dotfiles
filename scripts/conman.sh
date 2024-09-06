#!/bin/bash

dialog --colors \
       --backtitle "\Z7\Z7Red background\Zn" \
       --title "\Z7\Z7Green background\Zn" \
       --msgbox "Message with default colors" 10 40



choice=$(dialog --menu "Choose an option" 12 45 5 \
    1 "Option 1" \
    2 "Option 2" \
    3 "Option 3" \
    2>&1 >/dev/tty)

case $choice in
    1) echo "You chose Option 1";;
    2) echo "You chose Option 2";;
    3) echo "You chose Option 3";;
    *) echo "No option chosen";;
esac