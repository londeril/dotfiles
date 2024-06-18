#!/bin/bash
# this script will bring the NetworkManager Connection "Setup NIC Manual" down and up again - usefull after setting a new IPv4 address on the connection
ConnectionName="Setup NIC Manual"
nmcli connection down "$ConnectionName"
sleep 2
nmcli connection up "$ConnectionName"
