#!/bin/bash
# this script will mount, unmount and check the status of $MOUNT

MOUNT="/mnt/ecm"
MOUNT1="/mnt/erlenhof/allgemein"
WG_MANAGER="~/.dotfiles/scripts/wireguard-manager.sh"
STATUS_MOUNTED_STR='{"text":"Mounted","class":"connected","alt":"mounted"}'
STATUS_UNMOUNTED_STR='{"text":"Unmounted","class":"disconnected","alt":"unmounted"}'

function local_mount() {
  mount $MOUNT
  mount $MOUNT1

}

function local_umount() {
  umount $MOUNT
  umount $MOUNT1

}

function status() {
  #check if //int.ecmacom.ch is mounted return the status of the grep command
  mount | grep -q "192.168.253.102" >/dev/null 2>&1
  return $?
}

function toggle() {
  # check status and act acordingly
  status &&
    if local_umount >/dev/null 2>&1; then
      {
        notify-send -u normal -t 3000 "shares unmounted"
      }
    else
      {
        notify-send -u critical -t 0 "Could not unmount shares."
      }
    fi ||
    if local_mount; then
      {
        notify-send -u normal -t 3000 "shares mounted"
      }
    else
      {
        notify-send -u critical -t 3000 "Could not mount shares."
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
