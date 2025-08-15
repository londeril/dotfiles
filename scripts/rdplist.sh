#!/bin/bash
# rdp menu - this script will feed a dmenu with available rdp sessions

# Array of RDPs - maybe you'll find a way to do this in one file in the feature

options=(
  "serl-tcpos-01"
  "serl-mgmt-03"
  "duresco-vbr1"
  "duresco-vbo1"
  "jumphost3genua"
  "veeamcc1genua"
  "vbr1pratteln"
  "e9-mgmt-01"
  "e9-file-01"
  "e9-dc-01"
  "vbr1genua"
  "vbo1genua"
  "dc2genua"
  "serl-file-01"
  "serl-rdah-01"
  "cloud-vbo-01"
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
  "serl-vd-01"
  "serl-print-02"
  "serl-print-01"
  "serl-exch-01"
  "serl-vbr-02"
  "serl-be-01"
  "serl-domisdmz-01"
  "serl-rdsh-02"
  "serl-domis-03"
  "sct-rdsh-01"
  "sct-dc-01"
  "sct-mgmt-01"
  "sct-rdsh-01-ecm.tester"
  "cloud-vbr-01"
  "serl-rdsh-02-d.mueller"
  "serl-rdsh-01-d.mueller"
  "serl-vbo-02"
  "serl-rdsh-01"
  "serl-rdcb-01"
  "serl-printc-01"
  "serl-dc-01"
  "serl-dc-02"
  "serl-dc-03"
  "ipl-vbo"
  "tcs-vbo"
  "serl-cti-01"
)

selected=$(printf '%s\n' "${options[@]}" | dmenu -l 10 -i -p "Which RDP Session?")

#selected=$(echo -e "vbr1genua\nserl-file-01\njumphost3genua" | dmenu -l 3 -p "test")

if [[ $selected ]]; then
  exec ~/.dotfiles/scripts/rdpconnect.sh $selected
fi
