#!/bin/bash
# this script will bring the NetworkManager Connection "Setup NIC Manual" down and up again - usefull after setting a new IPv4 address on the connection

case $1 in
	viper )
		ConnectionName="Setup NIC Manual"
		;;
	nova )
		ConnectionName="USB NIC - Manual"
esac

nmcli connection down "$ConnectionName"
sleep 2
nmcli connection up "$ConnectionName"
