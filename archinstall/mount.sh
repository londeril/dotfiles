sv_opts="rw,noatime,compress-force=zstd:1,space_cache=v2"
mount -o ${sv_opts},subvol=@ /dev/nvme0n1p3 /mnt
mount -o ${sv_opts},subvol=@home /dev/nvme0n1p3 /mnt/home
mount -o ${sv_opts},subvol=@cache /dev/nvme0n1p3 /mnt/var/cache
mount -o ${sv_opts},subvol=@libvirt /dev/nvme0n1p3 /mnt/var/lib/libvirt
mount -o ${sv_opts},subvol=@log /dev/nvme0n1p3 /mnt/var/log
mount -o ${sv_opts},subvol=@tmp /dev/nvme0n1p3 /mnt/var/tmp
mount -o ${sv_opts},subvol=@snapshots /dev/nvme0n1p3 /mnt/.snapshots
mount /dev/nvme0n1p1 /mnt/efi