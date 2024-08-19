#!/bin/bash
echo "Starting Bootstrap"
pacstrap -K /mnt base linux imagemagick ttf-lato libreoffice rsync noto-fonts-emoji linux-lts inotify-tools krita linux-firmware wireplumber pipewire-audio pipewire-alsa pipewire-pulse sof-firmware fastfetch cups cups-pdf nss-mdns powerline-fonts vi vim git curl wget zsh openssh man-db flatpak aspell-de sudo base-devel networkmanager grub efibootmgr less amd-ucode remmina firefox btop btrfs-progs htop pacman-contrib pkgfile reflector terminus-font tmux pipewire-jack alsa-utils sddm xorg nerd-fonts kitty plasma kde-applications
