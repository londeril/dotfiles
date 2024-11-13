#!/bin/bash
# docking helper
# this script will prepare the system to be (un)docked. We don't want to leave too much to autoconfig or chance...


check_location() {
  if hyprctl monitors | grep -q "Samsung Electric Company C34H89x H4ZR302295"; then
    echo "office"
  elif hyprctl monitors | grep -q "Put the home PhotoMonitor desc here"; then
    echo "home"
  else
    echo "local"
  fi
}



# let's see if and which external monitor is connected

if hyprctl monitors | grep -q "Samsung Electric Company C34H89x H4ZR302295"; then
  OFFICE=true
else
  OFFICE=false
fi

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
  hyprctl keyword monitor desc:HP Inc. HP E243i 6CM82505J0,prefered, 0x0,1,transform,1 >/dev/null
  hyprctl keyword monitor desc:Samsung Electric Company C34H89x H4ZR302295,3440x1440@100,auto,1 >/dev/null

  # move all desktops from the internal screen to the big screen
  # Define monitor descriptions
  MONITOR1="desc:HP Inc. HP E243i 6CM82505J0"
  #MONITOR1="desc:Samsung Electric Company S24E650 H4ZH201777"
  MONITOR2="desc:Samsung Electric Company C34H89x H4ZR302295"

  # Get all workspace IDs
  workspaces=$(hyprctl workspaces -j | jq -r '.[].id')

  # Move all other workspaces to MONITOR2
  for ws in $workspaces; do
    hyprctl dispatch moveworkspacetomonitor $ws $MONITOR2 >/dev/null
  done

  # Move workspace one to MONITOR1
  hyprctl dispatch moveworkspacetomonitor 1 $MONITOR1 >/dev/null

  # all is setup - disbale the internal display
  hyprctl keyword monitor desc:Sharp Corporation 0x14F7,disable >/dev/null

  # reload waybar
  ~/.dotfiles/scripts/launch.sh

  # since we are docked and we no longer rely on microsoft share point B$, we want to mount the local file share
  ~/.dotfiles/scripts/mounter.sh -t && pkill -SIGRTMIN+1 waybar

  # swap hyprlock config to the office one
  rm /home/daniel/.config/hypr/hyprlock.conf
  ln -s /home/daniel/.dotfiles/hypr/hyprlock.conf-nova-office /home/daniel/.config/hypr/hyprlock.conf

  # swap hypridle config to office
  rm /home/daniel/.config/hypr/hypridle.conf
  ln -s /home/daniel/.dotfiles/hypr/hypridle.conf-nova-office /home/daniel/.config/hypr/hypridle.conf
  pkill hypridle
  hypridle &!

  # kill and restart hyprpaper, for good measure
  pkill hyprpaper
  hyprpaper &!

  ;;
--undock)
  # the system is currently docked but we want to unplug the dock.
  # move desktops to internal display and reload waybar

  # first let's compensate for our own supidity - if there is no external monitor and we where called to undock... well...
  # there's nothing to do really...

  if [ $OFFICE == "false" ]; then
    notify-send -u critical -t 0 "Silly me" "wanted to undock without being docked first... silly..."
    exit 1
  fi

  # check if network drives are still mounted - if they are abort
  if mount | grep 'ecm'; then
    notify-send -u critical -t 0 "Netshare Mounted" "will not undock with mounted network shares - unmount them!"
    exit 1
  fi

  # enable internal screen
  #  hyprctl keyword monitor desc:Sharp Corporation 0x14F7,enable >/dev/null
  hyprctl keyword monitor desc:Sharp Corporation 0x14F7,prefered,auto,1 >/dev/null

  # Define monitor descriptions
  INTMONITOR="desc:Sharp Corporation 0x14F7"

  # Get all workspace IDs
  workspaces=$(hyprctl workspaces -j | jq -r '.[].id')

  # Move all other workspaces to INTMONITOR
  for ws in $workspaces; do
    hyprctl dispatch moveworkspacetomonitor $ws $INTMONITOR >/dev/null
  done

  # notify the user that it's now time to unplug the monitor
  notify-send -u critical -t 0 "We are clear to undock :)"

  # reload waybar
  ~/.dotfiles/scripts/launch.sh

  # swap hyprlock config to laptop mode
  rm /home/daniel/.config/hypr/hyprlock.conf
  ln -s /home/daniel/.dotfiles/hypr/hyprlock.conf-nova-local /home/daniel/.config/hypr/hyprlock.conf

  # swap hypridle config to laptop mode
  rm /home/daniel/.config/hypr/hypridle.conf
  ln -s /home/daniel/.dotfiles/hypr/hypridle.conf-nova-local /home/daniel/.config/hypr/hypridle.conf
  pkill hypridle
  hypridle &!
  
  # disbale external monitor
  hyprctl keyword monitor desc:Samsung Electric Company S24E650 H4ZH201777,disable >/dev/null
  hyprctl keyword monitor desc:Samsung Electric Company C34H89x H4ZR302295,disbale >/dev/null


  ;;
*)
  echo "usage: --dock --undock"
  ;;
esac
