#!/bin/bash

check_status() {
  status=$(nmcli radio wifi)
  if [[ $status == "disabled" ]]; then
    notify-send "WiFi is off - turning it on"
    nmcli radio wifi on
  else
    notify-send "WiFi is on - tunring it off"
    nmcli radio wifi off
  fi
}

check_status
