#!/bin/bash
# this script opens all apps that I use all the time and moves them to the correct workspaces

# define the apps
apps=(
  "zen-browser"
  "flatpak run com.todoist.Todoist"
  "md.obsidian.Obsidian"
  "thunderbird"
  "flatpak run com.rtosta.zapzap"
  "kitty --class=remlauncher --directory /home/daniel/.dotfiles/scripts/"
)

# open all apps from the apps array
for app in "${apps[@]}"; do
  eval "$app" &
done
