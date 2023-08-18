#!/bin/bash
# this script will check if Nova's sshkey is loaded, will load it if not and launch nccm

# check for key identity
echo "looking for loaded ssh-key"
if ssh-add -l | grep "daniel@nova"; then
	echo "ssh-key is loaded, launching nccm"
	nccm-bin
else 
	echo "ssh-key is not loaded, adding..."
	ssh-add /home/daniel/.ssh/danielatnova
	echo "checking again"
	if ssh-add -l | grep "daniel@nova"; then
		echo "ssh-key is loaded, launching nccm"
		nccm-bin
	fi
fi
