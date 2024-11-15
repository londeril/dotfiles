#!/bin/bash
sleep 4
systemctl --user stop xdg-desktop-portal-gtk
systemctl --user stop xdg-desktop-portal
sleep 4
systemctl --user start xdg-desktop-portal
/usr/lib/xdg-desktop-portal-hyprland &
systemctl --user start xdg-desktop-portal-gtk
