#!/bin/bash
export LC_ALL=C

enable_disable_wifi ()
{
  result=$(nmcli dev | grep "ethernet" | grep -w "connected")
  if [ -n "$result" ]; then
    nmcli radio wifi off
  else
    nmcli radio wifi on
  fi
}

if [ "$2" = "up" ]; then
  enable_disable_wifi
fi

if [ "$2" = "down" ]; then
  enable_disable_wifi
fi

