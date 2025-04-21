#!/bin/bash
# this script will toggle the wireguard tunnel $TUNNEL. or print it's status

# if $2 was supplied take this as the tunnel name

TUNNEL="office"
if [ -n "$2" ]; then
    TUNNEL=$2
    
fi
STATUS_CONNECTED_STR='{"text":"Connected","class":"connected","alt":"connected"}'
STATUS_DISCONNECTED_STR='{"text":"Disconnected","class":"disconnected","alt":"disconnected"}'

function status_wireguard() {
  nmcli -t -f GENERAL.STATE connection show "$TUNNEL" | grep -q "activated" >/dev/null 2>&1
  return $?
}

function any_wireguard() {
  nmcli -t connection show --active | \
    awk -F: '$3 == "wireguard" { found=1 } END { exit !found }'
  return $?
}

function toggle_wireguard() {
  if status_wireguard; then
    if ~/.dotfiles/scripts/mounter.sh -s | grep -q "\bmounted\b"; then
      notify-send -u critical -t 0 "/mnt/ecm is mounted - will not bring Tunnel down"
      exit 1
    else
      nmcli connection down $TUNNEL
      notify-send -u normal -t 3000 "bringing WireGurad Tunnel $TUNNEL down"
    fi
  else
    nmcli connection up $TUNNEL
    notify-send -u normal -t 3000 "bringing WireGurad Tunnel $TUNNEL up"
  fi
  pkill -SIGRTMIN+1 waybar
}

case $1 in
-s | --status)
  status_wireguard && echo $STATUS_CONNECTED_STR || echo $STATUS_DISCONNECTED_STR
  ;;
-t | --toggle)
  toggle_wireguard
  ;;
-a | --any)
  #check if any tunnel is up (useful for status light on waybar)
  any_wireguard && echo $STATUS_CONNECTED_STR || echo $STATUS_DISCONNECTED_STR
  ;;
*)
  echo "Usage: $0 {-s|--status|-t|--toggle}"
  ;;
esac
