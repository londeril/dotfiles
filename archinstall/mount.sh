sv_opts="rw,noatime,compress-force=zstd:1,space_cache=v2"
mount -o ${sv_opts},subvol=@ /dev/nvme0n1p3 /mnt
mount -o ${sv_opts},subvol=@home /dev/nvme0n1p3 /mnt/home
mount -o ${sv_opts},subvol=@snapshots /dev/nvme0n1p3 /mnt/.snapshots
mount /dev/nvme0n1p1 /mnt/boot