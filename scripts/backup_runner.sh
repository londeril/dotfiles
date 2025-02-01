#!/bin/bash
# this script will run a backup of the user folder excluding temparary and cloud data

backup() {
  pkexec restic -r sftp:daniel@172.16.3.10:/mnt/backup/RavenBackup backup / --password-file="/home/daniel/.RavenBackup" --exclude-file="/home/daniel/.dotfiles/raven-excludes.restic"
  CURRENTDATE=$(date "+%d. %b. %T")
  echo "$CURRENTDATE" >/home/daniel/.config/latest_backup
  echo "backup run done"
}

vpn_connect() {
  nmcli connection up home
}

vpn_disconnect() {
  nmcli connection down home
}

server_check() {
  if ping -c 1 -W 1 172.16.3.10 &>/dev/null; then
    return 0
  else
    return 1
  fi

}

case "$1" in
backup)
  echo "Starting Backup run"
  if server_check; then
    backup
    # wait for user to press a key to close
    cowsay -f tux "I'm done!"
    read -n 1 -s -r -p "Run completed - press any key to close this window"
  else
    echo "Server not reachable. trying to bring VPN up"
    vpn_connect
    if server_check; then
      echo "Server reachable, running backup"
      backup
      vpn_disconnect
      cowsay -f tux "I'm done!"
      read -n 1 -s -r -p "Run completed - press any key to close this window"
    else
      echo "server still not reachable, giving up"
      read -n 1 -s -r -p "Run failed - press any key to close this window"
      exit 1
    fi
  fi
  ;;
snapshots)
  restic -r sftp:daniel@172.16.3.10:/mnt/backup/RavenBackup snapshots --password-file /home/daniel/.RavenBackup
  ;;
*)
  echo "Usage: backup-runner backup|snapshots"
  ;;
esac
