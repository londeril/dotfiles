#!/bin/bash
# wireguard tunnel chooser with status indicators

# Get connections with status (UP/DOWN)
readarray -t connections < <(nmcli -t connection show | awk -F: '
  $3 == "wireguard" {
    status = ($4 == $1) ? "🟢" : "🔴";
    print $1 " " status
  }
')

# Show in dmenu with status emoji
selected=$(printf '%s\n' "${connections[@]}" | dmenu -l 10 -i -p "Which Wireguard Tunnel?")

# Extract connection name (remove status emoji)
if [[ $selected ]]; then
  tunnel=$(echo "$selected" | awk '{print $1}')
  exec ~/.dotfiles/scripts/wireguard-manager.sh --toggle "$tunnel"
fi










# wireguard tunnel chooser - to be used with wireguard-manager.sh

# Read WireGuard connection names into array
#IFS=$'\n' read -d '' -r -a options < <(nmcli -t connection show | awk -F: '$3 == "wireguard" {print $1}')

# feed the options array to dmenu
#selected=$(printf '%s\n' "${options[@]}" | dmenu -l 10 -i -p "Which Wireguard Tunnel?")

# call wireguard-manager with the selected tunnel
#if [[ $selected ]]; then
#  exec ~/.dotfiles/scripts/wireguard-manager.sh --toggle $selected
#fi
