#!/bin/bash

check_status() {
  status=$(nmcli -f GENERAL.STATE device show wlp3s0 | awk '{print $2}')
  #status=$(nmcli radio wifi)
  if [[ $status == "30" ]]; then
    notify-send "WiFi is off - turning it on"
    nmcli device connect wlp3s0
    #nmcli radio wifi on
  else
    notify-send "WiFi is on - tunring it off"
    nmcli device disconnect wlp3s0
    #nmcli radio wifi off
  fi
}

check_status
