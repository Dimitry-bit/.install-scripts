#!/usr/bin/env bash

set -euo pipefail

if ! [[ $(id -u) = 0 ]]; then
  echo "error: Run this script using sudo." >&2
  exit 1
fi

readonly COPRS_REPOSITORIES=(
  avengemedia/dms
)

readonly NIRI_PACKAGES=(
  # Provides all gnome core apps. Serves as a fallback if niri breaks.
  @gnome-desktop

  playerctl
  brightnessctl

  niri
  dms
)

install_niri() {
  for repo in "${COPRS_REPOSITORIES[@]}"; do
    dnf copr enable -y "${repo}"
  done
  dnf install -y "${NIRI_PACKAGES[@]}"

  systemctl enable gdm.service
  systemctl --user add-wants niri.service dms
}

install_niri
