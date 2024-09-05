!#/bin/bash
SERVER="192.168.73.20"
USERNAME="sysmin"
DOMAIN="localhost"
PASSWORD=$(secret-tool lookup duresco-vbr1 password)

xfreerdp3 /v:$SERVER /u:$USERNAME /d:$DOMAIN /p:"$PASSWORD" +dynamic-resolution /drive:RDPShare,/home/daniel/RDPShare +clipboard