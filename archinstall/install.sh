#!/bin/sh
# Arch Linux installation script (2023)
# this script assumes that you did partition your disk(s) and mounted them under /mnt
# since this will change from machine to machine.

# making sure de_CH-latin1 it the current keyboard layout
echo "Setting Keyboard Layout to Swiss German"
loadkeys de_CH-latin1

# bootstrappig
echo "Starting Bootstrap"
pacstrap -K /mnt base linux linux-firmware freerdp fuzzel nm-connection-editor network-manager-applet neofetch ranger python-pillow libnotify bind cups cups-pdf nss-mdns evince powerline-fonts vi vim git curl wget zsh openssh man-db flatpak nerd-fonts aspell-de thunderbird flameshot obsidian sudo base-devel networkmanager grub efibootmgr less amd-ucode hyprland waybar wofi dunst lxappearance breeze breeze-gtk pavucontrol grim hyprpaper kitty remmina xdg-desktop-portal-hyprland firefox btop flatpak nautilus virt-manager

echo "generating fstab from current mounts"
genfstab -U /mnt >> /mnt/etc/fstab

cp /root/chroot.sh /mnt/root/

echo "run arch-chroot /mnt now - this can't be scripted"
