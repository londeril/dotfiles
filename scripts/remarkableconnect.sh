#!/bin/bash
# this script will connect to RDP Servers using the supplied args

PASSWORD=$(
  op item get "Erlenhof Domain" --account "XJ2VK47Q2BCFFMRN24UZXH24B4" --vault "Employee" --format=json | jq -r '.fields[] | select(.type=="CONCEALED").value'
)

#op item get "$SECRETLOOKUP" --vault $VAULT --fields password --reveal

#secret-tool lookup $SECRETLOOKUP password

#xfreerdp3 /v:$IP /u:$USERNAME /d:$DOMAIN /p:"$PASSWORD" +dynamic-resolution /kbd:layout:0x00000807 /drive:RDPShare,/home/daniel/RDPShare +clipboard /cert:ignore &

xfreerdp3 /home/daniel/Data/rdps/Erlenhof_RemoteApp_reMarkable.rdp /u:d.mueller /d:ERLENHOF01 /p:"$PASSWORD" /kbd:layout:0x00000807 /cert:ignore &
