#!/bin/bash
sleep 4
killall -e xdg-desktop-portal-wlr
killall xdg-desktop-portal
killall xdg-desktop-portal-kde
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 4
/usr/libexec/xdg-desktop-portal &
