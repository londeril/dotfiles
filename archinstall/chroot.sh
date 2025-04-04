#!/bin/sh
# Arch Linux Installation Script (2023)
# script to run inside chroot

echo "doing locale config"
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
echo "LANG=en_US.UTF-8" >/etc/locale.conf
echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
locale-gen
echo "KEYMAP=de_CH-latin1" >/etc/vconsole.conf
echo "XKBLAYOUT=ch" >>/etc/vconsole.conf
echo "FONT=sun12x22" >>/etc/vconsole.conf

echo "generating adjtime"
hwclock --systohc

echo "setting hostname"
echo "varchi" >/etc/hostname

echo "adding hosts entries"
echo "127.0.0.1   localhost" >>/etc/hosts
echo "::1         localhost" >>/etc/hosts
echo "127.0.1.1   varchi.localdomain raven" >>/etc/hosts

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
#systemctl enable ly
systemctl enable cups.socket
systemctl enable avahi-daemon
systemctl enable libvirtd
systemctl enable fstrim.timer
systemctl enable grub-btrfsd
systemctl enable btrfs-scrub@-.timer
#systemctl enable nftables

cp -r /root/dotfiles /home/daniel/.dotfiles
chown daniel /home/daniel/.* -R

echo "configuring grub"
#grub-install --target=i386-pc /dev/vda # BIOS
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB # UEFI
grub-mkconfig -o /boot/grub/grub.cfg

echo "updating mirrors"
reflector --verbose --protocol https --latest 5 --sort rate --country Switzerland --save /etc/pacman.d/mirrorlist

echo "configuring pam.d for howdy"
sudo cp /root/dotfiles/archinstall/pam.d/* /etc/pam.d/

echo "enabling mdns"
sudo cp /root/dotfiles/archinstall/etc/nsswitch.conf /etc/

#echo "enabling wlan auto toggle dispatcher"
#sudo cp /root/dotfiles/archinstall/etc/NetworkManager/dispatcher.d/wlan_auto_toggle.sh /etc/NetworkManager/dispatcher.d/

echo "removing subvolids from fstab"
sudo sed -i 's/subvolid=.*,//' /etc/fstab

echo "copying pacman hooks"
mkdir /etc/pacman.d/hooks
cp /root/dotfiles/archinstall/hooks/* /etc/pacman.d/hooks/

echo "removing dotfiles from root's user context"
rm -r /root/dotfiles

echo "exit add encrypt to hooks in etc/mkinitcpio.conf before filesystems, run mkinitcpio -P, add cryptdevice=UUID=the-uuid:root root=/dev/mapper/root to /etc/default/grub and run grub-mkconfig -o /boot/grub/grub.cfg and reboot"
