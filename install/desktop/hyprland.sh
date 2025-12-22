#!/usr/bin/env bash

set -euo pipefail

if ! [[ $(id -u) = 0 ]]; then
  echo "error: Run this script using sudo." >&2
  exit 1
fi

readonly COPRS_REPOSITORIES=(
  solopasha/hyprland
  erikreider/SwayNotificationCenter
  erikreider/packages
)

readonly HYPRLAND_PACKAGES=(
  hypridle
  hyprland
  hyprland-qt-support
  hyprland-qtutils
  hyprlock
  hyprpicker
  hyprshot
  hyprsunset
  hyprpolkitagent
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  waybar
  rofi
  brightnessctl

  # Sway Utils
  swaybg
  SwayNotificationCenter
  swayosd-git

  # Bluetooth
  blueman
  blueman-nautilus

  # Network
  network-manager-applet

  # Wayland
  qt5-qtwayland
  qt6-qtwayland
  wl-clipboard
  uwsm
  brightnessctl

  # Gnome core applications
  gnome-disk-utility
  gnome-calculator
  gnome-keyring
  gnome-themes-extra
  gnome-font-viewer
  gnome-logs
  gnome-weather
  gnome-clocks
  gnome-characters
  gnome-calendar
  decibels
  snapshot
  baobab
  nautilus
  papers
  loupe
)

install_hyprland() {
  for repo in "${COPRS_REPOSITORIES[@]}"; do
    dnf copr enable -y "${repo}"
  done
  dnf install -y "${HYPRLAND_PACKAGES[@]}"

  systemctl enable gdm.service
}

install_hyprland
