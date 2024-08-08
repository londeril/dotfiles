#!/bin/sh
# Arch Linux installation script (2024)
# 

# bootstrappig
echo "Starting Bootstrap"

pacstrap -K /mnt base linux libreoffice noto-fonts-emoji linux-zen brightnessctl polkit-gnome polkit-kde-agent libreoffice qt5ct qt6ct inotify-tools qt5-graphicaleffects qt5-quickcontrols krita linux-firmware libvirt iptables-nft dnsmasq qemu-full wireplumber pipewire-audio pipewire-alsa pipewire-pulse sof-firmware nm-connection-editor network-manager-applet fastfetch ranger python-pillow bind cups cups-pdf nss-mdns evince powerline-fonts vi vim git curl wget zsh openssh man-db flatpak aspell-de thunderbird obsidian sudo base-devel networkmanager grub efibootmgr less amd-ucode remmina firefox btop virt-manager btrfs-progs cryptsetup htop pacman-contrib pkgfile reflector terminus-font tmux pipewire-jack alsa-utils sddm xorg nautilus nerd-fonts hyprland hyprpaper hyprlock hypridle waybar dunst rofi-wayland kitty
echo "generating fstab from current mounts"
genfstab -U /mnt > /mnt/etc/fstab

cp -r /root/dotfiles /mnt/root/

echo "run arch-chroot /mnt now - this can't be scripted"
