#!/usr/bin/env bash

set -euo pipefail

BASE_PACKAGES=(
  # Minimal Workstation Environment Groups
  @base-graphical
  @core
  @firefox
  @hardware-support
  @networkmanager-submodules
  @printing
  @workstation-product

  # Development
  @c-development
  @development-tools
  gh
  neovim
  alacritty

  # Better core-utils
  bash-completion
  bat
  btop
  fd
  fzf
  lsd
  plocate
  tldr
  zoxide
  stow
  ripgrep
  unrar
  curl
  magick

  flatpak
)

if ! [[ $(id -u) = 0 ]]; then
    echo "error: run this script with sudo." >&2
    exit 1
fi

setup_base() {
  dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

  dnf install -y "${BASE_PACKAGES[@]}"

  systemctl set-default graphical.target
}

setup_multimedia() {
  # Replace neutered ffmpeg with the real one
  dnf swap -y ffmpeg-free ffmpeg --allowerasing

  # Install GStreamer plugins
  dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} \
    gstreamer1-plugin-openh264 gstreamer1-libav lame\* \
    --exclude=gstreamer1-plugins-bad-free-devel

  # Install multimedia groups
  dnf group install -y multimedia sound-and-video

  # Install VA-API for hardware acceleration
  dnf install -y ffmpeg-libs libva libva-utils

  # Install Cisco OpenH264 codec
  dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264
}

setup_flatpak() {
  if ! command -v flatpak &>/dev/null; then
    dnf install -y flatpak
  fi

  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

setup_terra() {
    dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
}

setup_base
setup_multimedia
setup_flatpak
# setup_terra
