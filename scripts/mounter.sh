#!/bin/bash
# this script will mount, unmount and check the status of $MOUNT

MOUNT="/mnt/ecm"
WG_MANAGER="~/.dotfiles/scripts/wireguard-manager.sh"
STATUS_MOUNTED_STR='{"text":"Mounted","class":"connected","alt":"mounted"}'
STATUS_UNMOUNTED_STR='{"text":"Unmounted","class":"disconnected","alt":"unmounted"}'

function status() {
  #check if //int.ecmacom.ch is mounted return the status of the grep command
  mount | grep -q "192.168.253.101" >/dev/null 2>&1
  return $?
}

function toggle() {
  # check status and act acordingly
  status &&
    if umount $MOUNT >/dev/null 2>&1; then
      {
        notify-send -u normal -t 3000 "$MOUNT unmounted"
      }
    else
      {
        notify-send -u critical -t 0 "Could not unmount $MOUNT."
      }
    fi ||
    if mount $MOUNT; then
      {
        notify-send -u normal -t 3000 "$MOUNT mounted"
      }
    else
      {
        notify-send -u critical -t 3000 "Could not mount $MOUNT."
      }
    fi
}

case $1 in
-s | --status)
  status && echo $STATUS_MOUNTED_STR || echo $STATUS_UNMOUNTED_STR
  ;;
-t | --toggle)
  toggle
  ;;
*)
  echo "Usage: $0 {-s|--status|-t|--toggle}"
  ;;
esac
