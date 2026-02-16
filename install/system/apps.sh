#!/usr/bin/env bash

set -euo pipefail

DNF_PACKAGES=(
  thunderbird
)

TERRA_PACKAGES=(
    zed
    starship
)

FLATHUB_PACKAGES=(
  md.obsidian.Obsidian
  io.missioncenter.MissionCenter
  io.github.kolunmi.Bazaar
  io.github.alainm23.planify
  org.gnome.World.Secrets
)

setup_apps() {
  sudo dnf install -y "${DNF_PACKAGES[@]}" "${TERRA_PACKAGES[@]}"
  flatpak install -y flathub "${FLATHUB_PACKAGES[@]}"
}

setup_apps
