#!/bin/bash

virt-install \
  --name vArchi \
  --memory 8192 \
  --memory maxmemory=8192 \
  --memballoon virtio \
  --vcpus 4 \
  --disk size=100,bus=virtio \
  --network=default,model=virtio \
  --os-variant archlinux \
  --boot uefi \
  --graphics spice,gl.enable=yes,listen=none \
  --video virtio,accel3d=yes \
  --cpu host-passthrough \
  --cdrom /home/daniel/ISOs/archlinux-x86_64.iso \
  --virt-type kvm
