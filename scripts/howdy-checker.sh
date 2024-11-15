#!/bin/bash
# this script will check if it is wise to let the user authenticate using howdy
# we DON'T want face unlocks after resume from sleep - but we are fine with face-unlicks after the password
# has been entered once for a resumed session
# exit 0 to allow howdy, exit 1 to deny howdy

# this script can be used for the following:
# set suspend flag: the machine suspended
# remove suspend flag: the machine woke from sleep
# check flag: check if the flag is present and exit accordingly
# set suspend and suspend: when not called via an idle daemon, set flag and suspend the machine

case "$1" in
set_suspend)
  echo "1" >/tmp/suspend
  loginctl lock-session
  ;;
remove_suspend)
  echo "0" >/tmp/suspend
  ;;
check_suspend)
  if [ -f /tmp/suspend ] && [ "$(cat /tmp/suspend)" = "1" ]; then
    # machine woke from suspend and no password unlock happend so far
    # DO NOT permit face-unlock
    #echo "howdy deny"
    exit 1
  elif [ -f /tmp/suspend ] && [ "$(cat /tmp/suspend)" = "0" ]; then
    # there was a password unlock since last wake up - allow hawdy
    #echo "howdy allow"
    exit 0
  else
    # check failed...better save than sorry - no howdy unlock
    #echo "howdy deny"
    exit 1
  fi
  ;;

set_suspend_suspend)
  echo "1" >/tmp/suspend
  loginctl lock-session
  sleep 3
  systemctl suspend
  ;;
esac
