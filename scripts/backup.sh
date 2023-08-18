#!/bin/bash
#
# rsync backup to external USB disk. This script will be ran once a week over lunch break (cron) and only if the disk is pressent
#
# get the current month
DATE=`date +%B`
# set the logfile
LOG=/opt/scripts/backupLogs/$DATE.log
# make sure our PATH is including everything we need
export PATH=/sbin:/bin:/usr/sbin:/usr/bin


# maybe someday you'll learn of a way to notify the user from a root shell...
#su daniel -c 'notify-send -u critical -t 0 "Backup" "Starting Weekly Backup"'
echo "-----------------------------------------------------------------------------------" >> $LOG
echo `date`" - Starting Backup Run" >> $LOG
echo "-----------------------------------------------------------------------------------" >> $LOG
echo "Opening LUKS Vault" >> $LOG
if cryptsetup open /dev/disk/by-uuid/9cb445d1-e2e2-41a3-80a4-e9b042ff2465 backup --key-file /home/daniel/.FPwofje; then
	echo "Trying to mount backupdisk" >> $LOG
	# try to mount the backup disk and carry on if it mounts
	if mount /dev/mapper/backup /mnt/backup; then
	    # make sure the disk is mounted - we don't want to backup the system to itself...
	    echo "Backup disk was mounted" >> $LOG
	    if grep -qs "/mnt/backup " /proc/mounts; then
	    	echo "Better check again - we don't want to backup to the local disk" >> $LOG
	    	# run a backup - archive, non-verbose, excluding temporary and floating, rsync it to the USB disk using a new folder per month
	    	echo "Starting Backup at: "`date` >> $LOG
	    	rsync -av --exclude={"home/kvm-images","home/daniel/pCloudDrive","var/lib/libvirt/images","dev","home/daniel/.cache","proc","tmp","sys","run","mnt","media","cdrom","lost+found","home/daniel/.config/microsoft-edge","home/daniel/.config/obsidian"} / /mnt/backup/$DATE >> $LOG
	    	# run a seperate job for qcow2 images - copy them in sparse mode (we still want them thin provisioned)
	    	echo "Starting qcow2 Backup at: "`date` >> $LOG
	    	rsync -av --sparse /home/kvm-images/ /mnt/backup/$DATE/home/ >> $LOG
	    	# wait a bit for the dust to settle
	    	echo "Backup completed at: "`date` >> $LOG
	    	sleep 10
	    	# unmount the backup disk
	    	echo "Unmounting Backupdisk" >> $LOG
	    	umount /mnt/backup
	    	echo "Closing LUKS Vault" >> $LOG
	    	cryptsetup close backup
		fi
	else
		echo "It's backup o'clock yet the disk was not there... holidays? We'll try again next week" >> $LOG
	fi
else
	echo "crytop unlock failed" >> $LOG
fi
if grep -qs "/mnt/backup " /proc/mounts; then
	echo "Backupdisk is still here... unmounting didn't go to plan... better alert someone" >> $LOG
	# maybe someday you'll learn of a way to notify the user from a root shell...
	# su daniel -c 'notify-send -u critical -t 0 "Backup Error" "Unmounting the disk failed"'
fi
# maybe someday you'll learn of a way to notify the user from a root shell...
#su daniel -c 'notify-send -u critical -t 0 "Backup" "Weekly Backup done - check for errors!"'
echo "-----------------------------------------------------------------------------------" >> $LOG
echo `date`" - Backup Run completed" >> $LOG
echo "-----------------------------------------------------------------------------------" >> $LOG
