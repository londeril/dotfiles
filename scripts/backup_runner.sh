#!/bin/bash
# this script will run a backup of the user folder excluding temparary and cloud data
case "$1" in
backup)
  pkexec restic -r sftp:daniel@172.16.3.10:/mnt/storage/DashwoodStore/NovaBackup backup / --password-file="/home/daniel/.NovaBackup" --exclude-file="/home/daniel/.dotfiles/nova-excludes.restic"
  CURRENTDATE=$(date "+%d. %b. %T")
  echo $CURRENTDATE >/home/daniel/.config/lastest_backup
  exec /home/daniel/.dotfiles/scripts/launch.sh
  ;;
snapshots)
  restic -r sftp:daniel@172.16.3.10:/mnt/storage/DashwoodStore/NovaBackup snapshots --password-file /home/daniel/.NovaBackup
  ;;
*)
  echo "Usage: backup-runner backup|snapshots"
  ;;
esac
