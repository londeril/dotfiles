#!/bin/bash
# rdp menu - this script will feed a dmenu with available rdp sessions

# Array of RDPs - maybe you'll find a way to do this in one file in the feature

options=(
	"serl-mgmt-02"
	"duresco-vbr1"
	"duresco-vbo1"
	"jumphost3genua"
	"veeamcc1genua"
	"vbr1pratteln"
	"e9-mgmg-01"
	"vbr1genua"
	)

selected=$(printf '%s\n' "${options[@]}" | dmenu -i -p "Select an option:")

#selected=$(echo -e "vbr1genua\nserl-file-01\njumphost3genua" | dmenu -l 3 -p "test")

if [[ $selected ]]; then
	exec ~/.dotfiles/scripts/rdpconnect.sh $selected
fi

