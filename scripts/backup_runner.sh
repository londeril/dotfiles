#!/bin/bash
# this script will run a backup of the user folder excluding temparary and cloud data
case "$1" in
backup)
  pkexec restic -r sftp:daniel@172.16.3.10:/mnt/backup/RavenBackup backup / --password-file="/home/daniel/.RavenBackup" --exclude-file="/home/daniel/.dotfiles/raven-excludes.restic"
  CURRENTDATE=$(date "+%d. %b. %T")
  echo $CURRENTDATE >/home/daniel/.config/latest_backup
  exec /home/daniel/.dotfiles/scripts/launch.sh
  ;;
snapshots)
  restic -r sftp:daniel@172.16.3.10:/mnt/backup/RavenBackup snapshots --password-file /home/daniel/.RavenBackup
  ;;
*)
  echo "Usage: backup-runner backup|snapshots"
  ;;
esac
