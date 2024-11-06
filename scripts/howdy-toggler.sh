#!/bin/bash
# this script will enable, disable and check the status of howdy unlocksT

HOWDYFILE="/tmp/suspend"
STATUS_ENABLED_STR='{"text":"Enabled","class":"enabled","alt":"enabled"}'
STATUS_DISABLED_STR='{"text":"Disabled","class":"enabled","alt":"disabled"}'

function status() {
  #check if howdy unlock are enabled or not
  content=$(cat $HOWDYFILE)

  if [ "$content" = "1" ]; then
    return 1
  elif [ "$content" = "0" ]; then
    return 0
  fi
}

function toggle() {
  # check status and act acordingly
  status && echo "1" >/tmp/suspend || echo "0" >/tmp/suspend

}

case $1 in
-s | --status)
  status && echo $STATUS_ENABLED_STR || echo $STATUS_DISABLED_STR
  ;;
-t | --toggle)
  toggle
  ;;
*)
  echo "Usage: $0 {-s|--status|-t|--toggle}"
  ;;
esac
