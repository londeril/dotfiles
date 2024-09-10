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
	"e9-mgmt-01"
	"e9-file-01"
	"e9-dc-01"
	"e9-vbr-01"
	"vbr1genua"
	"dns1grellingen"
	"vbo1genua"
	"dc1grellingen"
	"dc2genua"
	"file2genua"
	"file1grellingen"
	"dns2genua"
	"mgmt3genua"
	"dc1pratteln"
	"duresco-infor2"
	"duresco-rds1"
	"duresco-lmobile"
	"duresco-sql1"
	"duresco-mgmt1"
	"duresco-file1"
	"duresco-dc1"
	"duresco-dc2"
	"duresco-app1"
	"serl-medidata-01"
	)

selected=$(printf '%s\n' "${options[@]}" | dmenu -l 10 -i -p "Which RDP Session?")

#selected=$(echo -e "vbr1genua\nserl-file-01\njumphost3genua" | dmenu -l 3 -p "test")

if [[ $selected ]]; then
	exec ~/.dotfiles/scripts/rdpconnect.sh $selected
fi

