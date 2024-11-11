#!/bin/bash
# this script will run a backup of the user folder excluding temparary and cloud data
cd /home/daniel/BackupTest/
restic -r sftp:daniel@172.16.3.10:/mnt/storage/DashwoodStore/NovaBackup backup . --password-file="/home/daniel/.NovaBackup" --exclude-file="/home/daniel/.dotfiles/nova-excludes.restic"
