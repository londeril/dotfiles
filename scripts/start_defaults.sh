#!/bin/bash
# this script will set some sane defaults on hyprland start-up.
# this will prevent forgotten howdy activation and off-screen lockscreens
#
# check if we have to change some links
if [ "$(readlink -f /home/daniel/.config/hypr/hyprlock.conf)" != "/home/daniel/.dotfiles/hypr/hyprlock.conf-nova-local" ]; then
  # we are not using the local files on start-up - let's change the links
  rm /home/daniel/.config/hypr/hyprlock.conf
  rm /home/daniel/.config/hypr/hypridle.conf

  ln -s /home/daniel/.dotfiles/hypr/hyprlock.conf-nova-local /home/daniel/.config/hypr/hyprlock.conf
  ln -s /home/daniel/.dotfiles/hypr/hypridle.conf-nova-local /home/daniel/.config/hypr/hypridle.conf
fi

# now for howdy unlocks. the hope is that the howdy team will someday fix the security issue (https://github.com/boltgolt/howdy/issues/969). so let's not change stuff on our end and just "misuse" the suspend scrpt. Remember to re-enable stuff in /etc/pam.d/hyprlock
echo "1" >/tmp/suspend
