#!/usr/bin/env bash

set -euo pipefail

readonly NVIDIA_PACKAGES=(
  akmod-nvidia
  xorg-x11-drv-nvidia-cuda
  libva
  libva-nvidia-driver
  libva-utils
  vdpauinfo
)

if ! [[ $(id -u) = 0 ]]; then
  echo "error: Run this script using sudo." >&2
  exit 1
fi

if ! lspci | grep -i "nvidia" &>/dev/null; then
  echo "error: No NVIDIA card detected." >&2
  exit 1
fi

dnf update -y
dnf install -y "${NVIDIA_PACKAGES[@]}"
systemctl enable nvidia-{suspend,resume,hibernate}
