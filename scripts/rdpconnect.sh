#!/bin/bash
# this script will connect to RDP Servers using the supplied args

source ~/Data/LinuxConfigShare/rdpconnect.sh


PASSWORD=$(op item get "$SECRETLOOKUP" --vault $VAULT --fields password --reveal)

#secret-tool lookup $SECRETLOOKUP password

xfreerdp3 /v:$IP /u:$USERNAME /d:$DOMAIN /p:"$PASSWORD" +dynamic-resolution /kbd:layout:0x00000807 /drive:RDPShare,/home/daniel/RDPShare +clipboard /cert:ignore &