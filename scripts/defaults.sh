#!/bin/bash
# this script opens all apps that I use all the time and moves them to the correct workspaces

# define the apps
apps=(
  "zen-browser"
  "todoist"
  "obsidian"
  "thunderbird"
  "flatpak run com.rtosta.zapzap"
)

# open all apps from the apps array
for app in "${apps[@]}"; do
  eval "$app" &
done
