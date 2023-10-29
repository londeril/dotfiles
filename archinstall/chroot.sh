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
echo "Nova" > /etc/hostname

echo "adding hosts entries"
echo "127.0.0.1   localhost" >> /etc/hosts
echo "::1         localhost" >> /etc/hosts
echo "127.0.1.1   nova.localdomain nova" >> /etc/hosts

echo "Adding user"
useradd -m -s /bin/zsh -g users daniel
usermod -aG wheel daniel
sed -i "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /etc/sudoers


echo "user password?"
passwd daniel
echo "root password?"
passwd

echo "enabling services for next boot"
systemctl enable NetworkManager
systemctl enable sddm
systemctl enable cups.socket
systemctl enable avahi-daemon
systemctl enable libvirtd
systemctl enable fstrim.timer

echo "configuring grub"
#grub-install --target=i386-pc /dev/vda # BIOS
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB # UEFI
grub-mkconfig -o /boot/grub/grub.cfg

echo "updating mirrors"
reflector --verbose --protocol https --latest 5 --sort rate --country Switzerland --save /etc/pacman.d/mirrorlist

#echo "configuring snapper"
#sudo umount /.snapshots
#sudo rm -rf /.snapshots

#snapper -c root create-config /

#sudo btrfs subvolume delete .snapshots
#sudo mkdir /.snapshots
#sudo mount -a
#sudo chmod 750 /.snapshots
#sudo chown :wheel /.snapshots


echo "exit and reboot"
