#!/bin/bash
# this script will return some info about the current network - when asked nicely

case $1 in
	publicip )
		curl -4 -s ifconfig.me ;;
	gateway )
		ip route show default | awk '/default/ {print $3}' ;;
	dns ) 
		awk '/nameserver/ {print $2}' /etc/resolv.conf ;;
	* )
	echo "this script need some input... publicip, gateway or dns at the moment"
esac