#!/bin/bash
# this script opens all apps that I use all the time and moves them to the correct workspaces

# define the apps
apps=(
  "zen-browser"
  "flatpak run com.todoist.Todoist"
  "md.obsidian.Obsidian"
  "thunderbird"
  "flatpak run com.rtosta.zapzap"
  "kitty --class=floater --hold sh -c 'cowsay -f small "weeeeeeeeeeeeeeee"'"
)

# open all apps from the apps array
for app in "${apps[@]}"; do
  eval "$app" &
done
