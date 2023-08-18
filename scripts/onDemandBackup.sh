#!/bin/bash
#
# rsync backup to external SSD. This script will be ran on demand without checking for the disk... I hope you know that you have to attach the disk to write to it...
#
# get the current month
DATE=`date +%B`
# set the logfile
LOG=/opt/scripts/backupLogs/$DATE-onDemand.log
# make sure our PATH is including everything we need
export PATH=/sbin:/bin:/usr/sbin:/usr/bin


# maybe someday you'll learn of a way to notify the user from a root shell...
#su daniel -c 'notify-send -u critical -t 0 "Backup" "Starting Weekly Backup"'
echo "-----------------------------------------------------------------------------------" >> $LOG
echo `date`" - Starting Backup Run" >> $LOG
echo "-----------------------------------------------------------------------------------" >> $LOG
echo "Trying to mount backupdisk" >> $LOG
# try to mount the backup disk and carry on if it mounts
if mount /dev/disk/by-uuid/a18f48f3-0f97-4438-9e6e-de198b041a81 /mnt/onDemandBackup; then
    # make sure the disk is mounted - we don't want to backup the system to itself...
    echo "Backup disk was mounted" >> $LOG
    if grep -qs "/mnt/onDemandBackup " /proc/mounts; then
    	echo "Better check again - we don't want to backup to the local disk" >> $LOG
    	# run a backup - archive, non-verbose, excluding temporary and floating, rsync it to the USB disk using a new folder per month
    	echo "Starting Backup at: "`date` >> $LOG
    	rsync -av --exclude={"home/kvm-images","home/daniel/pCloudDrive","var/lib/libvirt/images","dev","home/daniel/.cache","proc","tmp","sys","run","mnt","media","cdrom","lost+found","home/daniel/.config/microsoft-edge","home/daniel/.config/obsidian"} / /mnt/onDemandBackup/$DATE >> $LOG
    	# run a seperate job for qcow2 images - copy them in sparse mode (we still want them thin provisioned)
    	echo "Starting qcow2 Backup at: "`date` >> $LOG
    	rsync -av --sparse /home/kvm-images /mnt/onDemandBackup/$DATE/home/ >> $LOG
    	# wait a bit for the dust to settle
    	echo "Backup completed at: "`date` >> $LOG
    	sleep 10
    	# unmount the backup disk
    	echo "Unmounting Backupdisk" >> $LOG
    	umount /mnt/onDemandBackup    	
	fi
else
	echo "It's backup o'clock yet the disk was not there... holidays? We'll try again next week" >> $LOG
fi
if grep -qs "/mnt/onDemandBackup " /proc/mounts; then
	echo "Backupdisk is still here... unmounting didn't go to plan... better alert someone" >> $LOG
	# maybe someday you'll learn of a way to notify the user from a root shell...
	# su daniel -c 'notify-send -u critical -t 0 "Backup Error" "Unmounting the disk failed"'
fi
# maybe someday you'll learn of a way to notify the user from a root shell...
#su daniel -c 'notify-send -u critical -t 0 "Backup" "Weekly Backup done - check for errors!"'
echo "-----------------------------------------------------------------------------------" >> $LOG
echo `date`" - Backup Run completed" >> $LOG
echo "-----------------------------------------------------------------------------------" >> $LOG
