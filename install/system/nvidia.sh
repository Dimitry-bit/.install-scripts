#!/usr/bin/env bash

set -euo pipefail

NVIDIA_PACKAGES=(
  akmod-nvidia
  xorg-x11-drv-nvidia-cuda
  libva
  libva-nvidia-driver
  libva-utils
  vdpauinfo
)

if ! lspci | grep -i "nvidia" &>/dev/null; then
  echo "error: no NVIDIA card detected." >&2
  exit 1
fi

sudo dnf update -y
sudo dnf install -y "${NVIDIA_PACKAGES[@]}"
sudo systemctl enable nvidia-{suspend,resume,hibernate}
