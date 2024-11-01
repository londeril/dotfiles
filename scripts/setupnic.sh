#!/bin/bash
# this script will bring the NetworkManager Connection "Setup NIC Manual" down and up again - usefull after setting a new IPv4 address on the connection

case $1 in
viper)
  ConnectionName="Setup NIC Manual"
  nmcli connection down "$ConnectionName"
  sleep 2
  nmcli connection up "$ConnectionName"
  ;;
nova)
  nmcli connection down "USB NIC - Manual"
  nmcli connection down "ECM Docked - SetupNIC"
  sleep 2
  nmcli connection up "USB NIC - Manual"
  nmcli connection up "ECM Docked - SetupNIC"
  ;;
esac
