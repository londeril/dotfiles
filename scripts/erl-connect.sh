#!/bin/bash

PASSWORD=$(op item get "ecmacom - mueller domain" --vault Employee --format=json | jq -r '.fields[] | select(.type=="CONCEALED").value')

xfreerdp3 /v:172.19.38.236 /u:d.mueller /d:ERLENHOF01 /p:"$PASSWORD" +dynamic-resolution /kbd:layout:0x00000807 /drive:RDPShare,/home/daniel/RDPShare +clipboard /cert:ignore &
