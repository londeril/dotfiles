#!/bin/bash
# dynamic rdp connection script
#
# ask the user for stuff
read -p "Server to connect to: " IP
read -p "Username to use: " USERNAME
read -p "Domain to use: " DOMAIN
read -s -p "Password: " PASSWORD

xfreerdp3 /v:$IP /u:$USERNAME /d:$DOMAIN /p:$PASSWORD +dynamic-resolution /kbd:layout:0x00000807 /drive:RDPShare,/home/daniel/RDPShare +clipboard /cert:ignore
