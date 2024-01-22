#!/usr/bin/env bash

STATUS=`insync status  | grep "Sync status:" | awk '{print $3}'`

if [[ $STATUS == 'SYNCED' ]]; then
	echo " 󰅟  "
elif [[ $STATUS == 'SYNCING' ]]; then
	echo " 󰘿  " 
elif [[ -z $STATUS ]]; then
	echo " INSYNC IS DOWN! "
fi

