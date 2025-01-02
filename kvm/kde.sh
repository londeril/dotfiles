#!/bin/bash

virt-install \
  --name KDENeon \
  --memory 8192 \
  --memory maxmemory=8192 \
  --memballoon virtio \
  --vcpus 8 \
  --disk size=100,bus=virtio \
  --network=default,model=virtio \
  --os-variant linux2022 \
  --boot uefi \
  --graphics spice,gl.enable=yes,listen=none \
  --video virtio,accel3d=yes \
  --tpm backend.type=passthrough \
  --cpu host-passthrough \
  --cdrom /home/daniel/ISOs/neon-user-20241229-0747.iso \
  --virt-type kvm
