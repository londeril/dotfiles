#!/bin/bash
echo "Starting Bootstrap"
#pacstrap -K /mnt base linux freerdp dmidecode swtpm gvfs-smb imagemagick eog gnome-disk-utility distrobox podman cifs-utils spice-gtk xdg-desktop-portal-hyprland xdg-desktop-portal-gtk gnome-system-monitor gnome-calculator seahorse wireguard-tools ttf-lato libreoffice gnome-keyring nwg-look rsync noto-fonts-emoji linux-zen brightnessctl polkit-gnome polkit-kde-agent qt5ct qt6ct inotify-tools qt5-graphicaleffects qt5-quickcontrols krita linux-firmware libvirt iptables-nft dnsmasq qemu-full wireplumber pipewire-audio pipewire-alsa pipewire-pulse sof-firmware nm-connection-editor network-manager-applet fastfetch ranger python-pillow bind cups cups-pdf nss-mdns evince powerline-fonts vim git curl wget zsh openssh man-db flatpak hunspell-de thunderbird obsidian sudo base-devel networkmanager grub efibootmgr less amd-ucode remmina firefox btop virt-manager btrfs-progs cryptsetup htop pacman-contrib pkgfile reflector terminus-font tmux pipewire-jack alsa-utils ly xorg nautilus nerd-fonts hyprland hyprpaper hyprlock hypridle waybar dunst rofi-wayland kitty nemo

pacstrap -K /mnt \
  base \
  linux \
  freerdp \
  dmidecode \
  swtpm \
  gvfs-smb \
  imagemagick \
  eog \
  gnome-disk-utility \
  distrobox \
  podman \
  cifs-utils \
  spice-gtk \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal-gtk \
  gnome-system-monitor \
  gnome-calculator \
  seahorse \
  wireguard-tools \
  ttf-lato \
  libreoffice \
  gnome-keyring \
  nwg-look \
  rsync \
  noto-fonts-emoji \
  linux-zen \
  brightnessctl \
  polkit-gnome \
  polkit-kde-agent \
  qt5ct \
  qt6ct \
  inotify-tools \
  qt5-graphicaleffects \
  qt5-quickcontrols \
  krita \
  linux-firmware \
  libvirt \
  iptables-nft \
  dnsmasq \
  qemu-full \
  wireplumber \
  pipewire-audio \
  pipewire-alsa \
  pipewire-pulse \
  sof-firmware \
  nm-connection-editor \
  network-manager-applet \
  fastfetch \
  ranger \
  python-pillow \
  bind \
  cups \
  cups-pdf \
  nss-mdns \
  evince \
  powerline-fonts \
  neovim \
  git \
  curl \
  wget \
  zsh \
  openssh \
  man-db \
  flatpak \
  hunspell-de \
  thunderbird \
  obsidian \
  sudo \
  base-devel \
  networkmanager \
  grub \
  efibootmgr \
  less \
  amd-ucode \
  remmina \
  firefox \
  btop \
  virt-manager \
  btrfs-progs \
  cryptsetup \
  htop \
  pacman-contrib \
  pkgfile \
  reflector \
  terminus-font \
  tmux \
  pipewire-jack \
  alsa-utils \
  ly \
  xorg \
  nautilus \
  nerd-fonts \
  hyprland \
  hyprpaper \
  hyprlock \
  hypridle \
  waybar \
  dunst \
  rofi-wayland \
  kitty \
  nemo

