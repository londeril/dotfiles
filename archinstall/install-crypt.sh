#!/bin/sh
# Arch Linux installation script (2024)
#

export disk="/dev/nvme1n1"
export crypt=/dev/mapper/root

# making sure de_CH-latin1 it the current keyboard layout
echo "Setting Keyboard Layout to Swiss German and updating mirrors"
loadkeys de_CH-latin1

echo "doing crypt setup"
cryptsetup -v luksFormat ${disk}p2
cryptsetup open ${disk}p2 root

echo "Updating pacman DB and generating mirror list"
pacman -Syy
reflector --verbose --protocol https --latest 5 --sort rate --country Switzerland --save /etc/pacman.d/mirrorlist

echo "Making sure time is correct"
timedatectl set-ntp true

echo "Formating partitions"
mkfs.vfat -F32 -n ESP ${disk}p1
#mkswap ${disk}p2
#mkfs.btrfs -L arch ${disk}p3 -f
mkfs.btrfs -L arch ${crypt} -f

echo "creating btrfs subvolumes and remounting accordingly"
mount ${crypt} /mnt
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
mount -o ${sv_opts},subvol=@ ${crypt} /mnt
mkdir -p /mnt/{home,.snapshots,var/cache,var/lib/libvirt,var/log,var/tmp,swap}
mount -o ${sv_opts},subvol=@snapshots ${crypt} /mnt/.snapshots
mount -o ${sv_opts},subvol=@home ${crypt} /mnt/home
mount -o ${sv_opts},subvol=@cache ${crypt} /mnt/var/cache
mount -o ${sv_opts},subvol=@libvirt ${crypt} /mnt/var/lib/libvirt
mount -o ${sv_opts},subvol=@log ${crypt} /mnt/var/log
mount -o ${sv_opts},subvol=@tmp ${crypt} /mnt/var/tmp
mount -o ${sv_opts},subvol=@swap ${crypt} /mnt/swap

#mount -o ${sv_opts},subvol=@ ${disk}p3 /mnt
#mkdir -p /mnt/{home,.snapshots,var/cache,var/lib/libvirt,var/log,var/tmp,swap}
#mount -o ${sv_opts},subvol=@snapshots ${disk}p3 /mnt/.snapshots
#mount -o ${sv_opts},subvol=@home ${disk}p3 /mnt/home
#mount -o ${sv_opts},subvol=@cache ${disk}p3 /mnt/var/cache
#mount -o ${sv_opts},subvol=@libvirt ${disk}p3 /mnt/var/lib/libvirt
#mount -o ${sv_opts},subvol=@log ${disk}p3 /mnt/var/log
#mount -o ${sv_opts},subvol=@tmp ${disk}p3 /mnt/var/tmp
#mount -o ${sv_opts},subvol=@swap ${disk}p3 /mnt/swap

echo "Mounting boot and activating swap"
mkdir /mnt/boot
mount ${disk}p1 /mnt/boot

#swapon ${disk}p2
btrfs filesystem mkswapfile --size 64g --uuid clear /mnt/swap/swapfile
swapon /mnt/swap/swapfile

# bootstrappig
./pacstrap.sh
echo "generating fstab from current mounts"
genfstab -U /mnt >/mnt/etc/fstab

cp -r /root/dotfiles /mnt/root/

echo "run arch-chroot /mnt now - this can't be scripted"
