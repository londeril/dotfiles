#!/bin/sh
# Arch Linux Installation Script (2023)
# script to run inside chroot

echo "doing locale config"
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "KEYMAP=de_CH-latin1" > /etc/vconsole.conf

echo "generating adjtime"
hwclock --systohc

echo "setting hostname"
echo "VArchi" > /etc/hostname

echo "Adding user"
useradd -m -s /bin/zsh -g users daniel
usermod -aG wheel daniel
sudoedit /etc/sudoers

echo "user password?"
passwd daniel
echo "root password?"
passwd

echo "enabling services for next boot"
systemctl enable NetworkManager
systemctl enable sshd
systemctl enable cups.socket
systemctl enable avahi-daemon

echo "configuring grub"
#grub-install --target=i386-pc /dev/vda # BIOS
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB # UEFI
grub-mkconfig -o /boot/grub/grub.cfg

echo "exit and reboot"
