#!/bin/bash
# docking helper
# this script will prepare the system to be (un)docked. We don't want to leave too much to autoconfig or chance...


check_location() {
  if hyprctl monitors | grep -q "Philips Consumer Electronics Company 34B2U6603 UK02509029162"; then
    echo "office"
  elif hyprctl monitors | grep -q "BenQ SW2700 M6J01353SL0"; then
    echo "home"
  else
    echo "local"
  fi
}

#check_location() {
#  if hyprctl monitors | grep -q "Samsung Electric Company C34H89x H4ZR302295"; then
#    echo "office"
#  elif hyprctl monitors | grep -q "BenQ SW2700 M6J01353SL0"; then
#    echo "home"
#  else
#    echo "local"
#  fi
#}



# let's see if and which external monitor is connected

if hyprctl monitors | grep -q "Philips Consumer Electronics Company 34B2U6603 UK02509029162"; then
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
    notify-send -u critical -t 0 "Not at the Office?" "wanted to dock without being anywhere near a dock... which is... silly..."
    exit 1
  fi

  # enable the external monitor(s)
#  hyprctl keyword monitor desc:HP Inc. HP E243i 6CM82505J0,prefered, 0x0,1,transform,1 >/dev/null
  hyprctl keyword monitor desc:Philips Consumer Electronics Company 34B2U6603 UK02509029162,3440x1440@120.0,auto,1,bitdepth,10 >/dev/null

  # move all desktops from the internal screen to the big screen
  # Define monitor descriptions
 # MONITOR1="desc:HP Inc. HP E243i 6CM82505J0"
  MONITOR2="desc:Philips Consumer Electronics Company 34B2U6603 UK02509029162"

  # Get all workspace IDs
  workspaces=$(hyprctl workspaces -j | jq -r '.[].id')

  # Move all other workspaces to MONITOR2
  for ws in $workspaces; do
    hyprctl dispatch moveworkspacetomonitor $ws $MONITOR2 >/dev/null
  done

  # move workspace 1 to MONITOR1
  # hyprctl dispatch moveworkspacetomonitor 1 desc:HP Inc. HP E243i 6CM82505J0
  hyprctl dispatch moveworkspacetomonitor 1 eDP-1 


  # move workspace 2 to MONITOR1
  # hyprctl dispatch moveworkspacetomonitor 2 desc:HP Inc. HP E243i 6CM82505J0
  hyprctl dispatch moveworkspacetomonitor 2 eDP-1


  # Move workspace one to internal display
  #hyprctl dispatch moveworkspacetomonitor 1 eDP-1 >/dev/null

  # all is setup - disbale the internal display
#  hyprctl keyword monitor eDP-1,disable >/dev/null
  #
  # all is setup - change scaling on eDP-1
  # hyprctl keyword monitor eDP-1,prefered,0x0,1.25
  
  # change waybar config to office
  rm /home/daniel/.config/waybar/config.jsonc
  ln -s /home/daniel/.dotfiles/waybar/config.jsonc-raven-office /home/daniel/.config/waybar/config.jsonc

  # swap hyprlock config to the office one
  rm /home/daniel/.config/hypr/hyprlock.conf
  ln -s /home/daniel/.dotfiles/hypr/hyprlock.conf-raven-office /home/daniel/.config/hypr/hyprlock.conf

  # swap hypridle config to office
  rm /home/daniel/.config/hypr/hypridle.conf
  ln -s /home/daniel/.dotfiles/hypr/hypridle.conf-raven-office /home/daniel/.config/hypr/hypridle.conf
  pkill hypridle
  hypridle &!

  # reload wallpapers
  waypaper --restore

  # since we are docked and we no longer rely on microsoft share point B$, we want to mount the local file share
  sleep 5
  ~/.dotfiles/scripts/mounter.sh -t && pkill -SIGRTMIN+1 waybar

  # reload waybar
  ~/.dotfiles/scripts/launch.sh

  ;;
--dock-home)
  # the system was docked at home - fire ob the external displays, disable the internal one, move desktops and reload 

  # enable the external monitor(s)
  
  hyprctl keyword monitor desc:Samsung Electric Company C34H89x H4ZR302295,3440x1440@120.0,0x0,1 >/dev/null
  hyprctl keyword monitor desc:BNQ BenQ SW2700 M6J01353SL0,prefered,auto,1 >/dev/null

  # move all desktops from the internal screen to the big screen
  # Define monitor descriptions
  MONITOR1="desc:BNQ BenQ SW2700 M6J01353SL0"
  MONITOR2="desc:Samsung Electric Company C34H89x H4ZR302295"

  # Get all workspace IDs
  workspaces=$(hyprctl workspaces -j | jq -r '.[].id')

  # Move all other workspaces to MONITOR2
  for ws in $workspaces; do
    hyprctl dispatch moveworkspacetomonitor $ws $MONITOR2 >/dev/null
  done

  # move workspace 1 to MONITOR1
  hyprctl dispatch moveworkspacetomonitor 1 $MONITOR1

  # Move workspace one to internal display
  #hyprctl dispatch moveworkspacetomonitor 1 eDP-1 >/dev/null

  # all is setup - disbale the internal display
  hyprctl keyword monitor eDP-1,disable >/dev/null
  #
  # all is setup - change scaling on eDP-1
  # hyprctl keyword monitor eDP-1,prefered,0x0,1.25
  
  # change waybar config to home
  rm /home/daniel/.config/waybar/config.jsonc
  ln -s /home/daniel/.dotfiles/waybar/config.jsonc-raven-home /home/daniel/.config/waybar/config.jsonc

  # swap hyprlock config to the home one
  rm /home/daniel/.config/hypr/hyprlock.conf
  ln -s /home/daniel/.dotfiles/hypr/hyprlock.conf-raven-home /home/daniel/.config/hypr/hyprlock.conf

  # swap hypridle config to home
  rm /home/daniel/.config/hypr/hypridle.conf
  ln -s /home/daniel/.dotfiles/hypr/hypridle.conf-raven-home /home/daniel/.config/hypr/hypridle.conf
  pkill hypridle
  hypridle &!

  # reload wallpapers
  waypaper --restore

  # reload waybar
  ~/.dotfiles/scripts/launch.sh

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
  hyprctl keyword monitor eDP-1,prefered,auto,1 >/dev/null

  # set scaling of internal Monitor to 1
  # hyprctl keyword monitor eDP-1,prefered,auto,1

  # Define monitor descriptions
#  INTMONITOR="desc:BOE 0x0C8E"

  # Get all workspace IDs
  workspaces=$(hyprctl workspaces -j | jq -r '.[].id')

  # Move all other workspaces to INTMONITOR
  for ws in $workspaces; do
    hyprctl dispatch moveworkspacetomonitor $ws $INTMONITOR >/dev/null
  done

  # change waybar config to standalone
  rm /home/daniel/.config/waybar/config.jsonc
  ln -s /home/daniel/.dotfiles/waybar/config.jsonc-raven /home/daniel/.config/waybar/config.jsonc

  # notify the user that it's now time to unplug the monitor
  notify-send -u critical -t 0 "We are clear to undock :)"

  # reload waybar
  ~/.dotfiles/scripts/launch.sh

  # swap hyprlock config to laptop mode
  rm /home/daniel/.config/hypr/hyprlock.conf
  ln -s /home/daniel/.dotfiles/hypr/hyprlock.conf-raven-local /home/daniel/.config/hypr/hyprlock.conf

  # swap hypridle config to laptop mode
  rm /home/daniel/.config/hypr/hypridle.conf
  ln -s /home/daniel/.dotfiles/hypr/hypridle.conf-raven-local /home/daniel/.config/hypr/hypridle.conf
  pkill hypridle
  hypridle &!
  
  # waypaper restore
  waypaper --restore

  # reload waybar
  ~/.dotfiles/scripts/launch.sh

  ;;

--undock-home)
  # the system is currently docked but we want to unplug the dock.
  # move desktops to internal display and reload waybar

  # first let's compensate for our own supidity - if there is no external monitor and we where called to undock... well...
  # there's nothing to do really...

  # enable internal screen
  hyprctl keyword monitor eDP-1,prefered,auto,1 >/dev/null

  # set scaling of internal Monitor to 1
  # hyprctl keyword monitor eDP-1,prefered,auto,1

  # Define monitor descriptions
  INTMONITOR="desc:BOE 0x0C8E"

  # Get all workspace IDs
  workspaces=$(hyprctl workspaces -j | jq -r '.[].id')

  # Move all other workspaces to INTMONITOR
  for ws in $workspaces; do
    hyprctl dispatch moveworkspacetomonitor $ws $INTMONITOR >/dev/null
  done

  # change waybar config to standalone
  rm /home/daniel/.config/waybar/config.jsonc
  ln -s /home/daniel/.dotfiles/waybar/config.jsonc-raven /home/daniel/.config/waybar/config.jsonc

  # notify the user that it's now time to unplug the monitor
  notify-send -u critical -t 0 "We are clear to undock :)"

  # reload waybar
  ~/.dotfiles/scripts/launch.sh

  # swap hyprlock config to laptop mode
  rm /home/daniel/.config/hypr/hyprlock.conf
  ln -s /home/daniel/.dotfiles/hypr/hyprlock.conf-raven-local /home/daniel/.config/hypr/hyprlock.conf

  # swap hypridle config to laptop mode
  rm /home/daniel/.config/hypr/hypridle.conf
  ln -s /home/daniel/.dotfiles/hypr/hypridle.conf-raven-local /home/daniel/.config/hypr/hypridle.conf
  pkill hypridle
  hypridle &!
  
  # waypaper restore
  waypaper --restore

  # reload waybar
  ~/.dotfiles/scripts/launch.sh

  ;;
*)
  echo "usage: --dock --undock"
  ;;
esac
