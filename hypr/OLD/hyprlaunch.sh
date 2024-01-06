#!/bin/sh
killall -15 ssh-agent
eval "$(ssh-agent)"
exec Hyprland
