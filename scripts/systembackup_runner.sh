#!/bin/bash
# this script will run a backup of the user folder excluding temparary and cloud data
case "$1" in
backup)
  cd /
  pkexec restic -r sftp:daniel@172.16.3.10:/mnt/storage/DashwoodStore/NovaSystemBackup backup / --password-file="/root/.NovaSystemBackup" --exclude-file="/root/novasystem-excludes.restic"
  CURRENTDATE=$(date "+%d. %b. %T")
  echo $CURRENTDATE >/home/daniel/.config/lastest_systembackup
  #exec /home/daniel/.dotfiles/scripts/launch.sh
  ;;
snapshots)
  pkexec restic -r sftp:daniel@172.16.3.10:/mnt/storage/DashwoodStore/NovaSystemBackup snapshots --password-file "/root/.NovaSystemBackup"
  ;;
*)
  echo "Usage: backup-runner backup|snapshots"
  ;;
esac
