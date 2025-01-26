#!/bin/bash
set -euo pipefail

# Ensure that the RPM Fusion Nvidia repository is enabled
sudo sed -i '/\[rpmfusion-nonfree-nvidia-driver\]/,/^$/s/^enabled=0/enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo

sudo rpm-ostree install -y --idempotent \
  akmod-nvidia \
  xorg-x11-drv-nvidia \
  xorg-x11-drv-nvidia-cuda \
  libva-nvidia-driver

sudo rpm-ostree kargs \
  --append-if-missing=rd.driver.blacklist=nouveau \
  --append-if-missing=modprobe.blacklist=nouveau \
  --append-if-missing=nvidia-drm.modeset=1 \
  --append-if-missing=nvidia_drm.fbdev=1 \
  --append-if-missing=nvidia.NVreg_EnableGpuFirmware=1 \
  --append-if-missing=nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1 \
  --append-if-missing=nvidia.NVreg_PreserveVideoMemoryAllocations=1 \
  --append-if-missing=nvidia.NVreg_TemporaryFilePath=/var/tmp
