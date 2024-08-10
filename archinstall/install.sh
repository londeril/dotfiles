#!/bin/sh
# Arch Linux installation script (2024)
# 

export disk="/dev/vda"

# making sure de_CH-latin1 it the current keyboard layout
echo "Setting Keyboard Layout to Swiss German and updating mirrors"
loadkeys de_CH-latin1



echo "Updating pacman DB and generating mirror list"
pacman -Syy
reflector --verbose --protocol https --latest 5 --sort rate --country Switzerland --save /etc/pacman.d/mirrorlist

echo "Making sure time is correct"
timedatectl set-ntp true

echo "Formating partitions"
mkfs.vfat -F32 -n ESP ${disk}1
mkfs.btrfs -L arch ${disk}2 -f


echo "creating btrfs subvolumes and remounting accordingly"
mount ${disk}2 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@libvirt
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@swap

umount /mnt
sv_opts="rw,noatime,compress-force=zstd:1,space_cache=v2"
mount -o ${sv_opts},subvol=@ ${disk}2 /mnt
mkdir -p /mnt/{home,.snapshots,var/cache,var/lib/libvirt,var/log,var/tmp,swap}
mount -o ${sv_opts},subvol=@snapshots ${disk}2 /mnt/.snapshots
mount -o ${sv_opts},subvol=@home ${disk}2 /mnt/home
mount -o ${sv_opts},subvol=@cache ${disk}2 /mnt/var/cache
mount -o ${sv_opts},subvol=@libvirt ${disk}2 /mnt/var/lib/libvirt
mount -o ${sv_opts},subvol=@log ${disk}2 /mnt/var/log
mount -o ${sv_opts},subvol=@tmp ${disk}2 /mnt/var/tmp
mount -o ${sv_opts},subvol=@swap ${disk}2 /mnt/swap

echo "Mounting boot and activating swap"
mkdir /mnt/boot
mount ${disk}1 /mnt/boot

#swapon ${disk}p2
btrfs filesystem mkswapfile --size 16g --uuid clear /mnt/swap/swapfile
swapon /mnt/swap/swapfile

# bootstrappig
./pacstrap.sh
echo "generating fstab from current mounts"
genfstab -U /mnt > /mnt/etc/fstab

cp -r /root/dotfiles /mnt/root/

echo "run arch-chroot /mnt now - this can't be scripted"
