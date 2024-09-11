#!/bin/bash
# unmount all mounted disks
swapoff -a
umount /mnt/.snapshots
umount /mnt/home
umount /mnt/var/cache
umount /mnt/var/lib/libvirt
umount /mnt/var/log
umount /mnt/var/tmp
umount /mnt/swap
umount /mnt/boot
umount /mnt