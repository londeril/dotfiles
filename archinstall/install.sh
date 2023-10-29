#!/bin/sh
# Arch Linux installation script (2023)
# this script assumes that you did partition your disk(s) and mounted them under /mnt
# since this will change from machine to machine.

export disk="/dev/nvme0n1"

# making sure de_CH-latin1 it the current keyboard layout
echo "Setting Keyboard Layout to Swiss German and updating mirrors"
loadkeys de_CH-latin1
reflector --verbose --protocol https --latest 5 --sort rate --country Switzerland --save /etc/pacman.d/mirrorlist

echo "formating"
mkfs.vfat -F32 -n ESP /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
mkfs.btrfs -L arch /dev/nvme0n1p3 -f

mount /dev/nvme0n1p3 /mnt

echo "creating btrfs subvolumes and remounting accordingly"
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@libvirt
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@snapshots

umount /mnt
sv_opts="rw,noatime,compress-force=zstd:1,space_cache=v2"
mount -o ${sv_opts},subvol=@ /dev/nvme0n1p3 /mnt
mkdir -p /mnt/{home,var/cache,var/lib/libvirt,var/log,var/tmp,.snapshots}
mount -o ${sv_opts},subvol=@home /dev/nvme0n1p3 /mnt/home
mount -o ${sv_opts},subvol=@cache /dev/nvme0n1p3 /mnt/var/cache
mount -o ${sv_opts},subvol=@libvirt /dev/nvme0n1p3 /mnt/var/lib/libvirt
mount -o ${sv_opts},subvol=@log /dev/nvme0n1p3 /mnt/var/log
mount -o ${sv_opts},subvol=@tmp /dev/nvme0n1p3 /mnt/var/tmp
mount -o ${sv_opts},subvol=@snapshots /dev/nvme0n1p3 /mnt/.snapshots

mkdir /mnt/efi
mount /dev/nvme0n1p1 /mnt/efi


# bootstrappig
echo "Starting Bootstrap"
#pacstrap -K /mnt base linux linux-firmware freerdp swayidle libvirt iptables-nft dnsmasq qemnu-full wireplumber pipewire-audio pipewire-alsa pipewire-pulse sof-firmware lxsession seatd fuzzel nm-connection-editor network-manager-applet neofetch ranger python-pillow libnotify bind cups cups-pdf nss-mdns evince powerline-fonts vi vim git curl wget zsh openssh man-db flatpak nerd-fonts aspell-de thunderbird flameshot obsidian sudo base-devel networkmanager grub efibootmgr less amd-ucode hyprland waybar wofi dunst lxappearance breeze breeze-gtk pavucontrol grim hyprpaper kitty remmina xdg-desktop-portal-hyprland firefox btop flatpak nautilus virt-manager

pacstrap -K /mnt base linux snapper snap-pac linux-lts krita linux-firmware libvirt iptables-nft dnsmasq qemu-full wireplumber pipewire-audio pipewire-alsa pipewire-pulse sof-firmware nm-connection-editor network-manager-applet neofetch ranger python-pillow bind cups cups-pdf nss-mdns evince powerline-fonts vi vim git curl wget zsh openssh man-db flatpak nerd-fonts aspell-de thunderbird obsidian sudo base-devel networkmanager grub efibootmgr less amd-ucode remmina firefox btop virt-manager btrfs-progs cryptsetup htop pacman-contrib pkgfile reflector terminus-font tmux pipewire-jack alsa-utils sddm xorg plasma plasma-wayland-session kde-applications

#pacstrap /mnt base base-devel ${microcode} btrfs-progs linux linux-firmware bash-completion cryptsetup htop man-db mlocate neovim networkmanager openssh pacman-contrib pkgfile reflector sudo terminus-font tmux pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber alsa-utils

echo "generating fstab from current mounts"
genfstab -U /mnt >> /mnt/etc/fstab

cp /dotfiles/chroot.sh /mnt/root/

echo "run arch-chroot /mnt now - this can't be scripted"
