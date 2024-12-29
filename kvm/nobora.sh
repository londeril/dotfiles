#!/bin/bash

virt-install \
  --name vWinterwolf \
  --memory 8192 \
  --memory maxmemory=8192 \
  --memballoon virtio \
  --vcpus 8 \
  --disk size=100,bus=virtio \
  --network=default,model=virtio \
  --os-variant fedora40 \
  --boot uefi \
  --graphics spice,gl.enable=yes,listen=none \
  --video virtio,accel3d=yes \
  --tpm backend.type=passthrough \
  --cpu host-passthrough \
  --cdrom /home/daniel/ISOs/Nobara-40-Official-2024-11-13.iso \
  --virt-type kvm
