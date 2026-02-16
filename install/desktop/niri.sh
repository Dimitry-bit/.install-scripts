#!/usr/bin/env bash

set -euo pipefail

NIRI_PACKAGES=(
  # Provides all gnome core apps. Serves as a fallback if niri breaks.
  @gnome-desktop

  playerctl
  brightnessctl

  niri
  dms
  vicinae
)

install_niri() {
  sudo dnf copr enable -y "avengemedia/dms"
  sudo dnf copr enable -y "quadratech188/vicinae"
  sudo dnf install -y "${NIRI_PACKAGES[@]}"

  sudo systemctl enable gdm.service
  systemctl --user add-wants niri.service dms
  systemctl --user enable vicinae
}

install_niri
