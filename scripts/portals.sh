#!/bin/bash
sleep 4
killall -9 xdg-desktop-portal-wlr
killall -9 xdg-desktop-portal
killall -9 xdg-desktop-portal-kde
killall -9 xdg-desktop-portal-gtk
/usr/lib/xdg-desktop-portal-hyprland &
sleep 4
# /usr/lib/xdg-desktop-portal-gtk &
/usr/lib/xdg-desktop-portal &
