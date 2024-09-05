#!/bin/bash
# this script will connect to RDP Servers using the supplied args
# $1 = Servername
# $2 = IP Address
# $3 = Username
# $4 = Domain


SERVERNAME=$1
IP=$2
USERNAME=$3
DOMAIN=$4
PASSWORD=$(secret-tool lookup $SERVERNAME password)


#SERVERNAME="duresco-vbr1"
#IP="192.168.73.20"
#USERNAME="sysmin"
#DOMAIN="localhost"

xfreerdp3 /v:$IP /u:$USERNAME /d:$DOMAIN /p:"$PASSWORD" +dynamic-resolution /drive:RDPShare,/home/daniel/RDPShare +clipboard /cert:ignore