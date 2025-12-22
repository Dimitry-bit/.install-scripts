#!/usr/bin/env bash

set -euo pipefail

readonly CORE_NONFREE_FONTS=(
  google-roboto-fonts
  google-arimo-fonts
  google-cousine-fonts
  google-tinos-fonts
  google-noto-sans-arabic-fonts
)

readonly NERD_FONTS=(
   JetBrainsMono
)

readonly TMP_DIR="$(mktemp -d)"

if [[ $(id -u) = 0 ]]; then
  FONT_DIR="/usr/local/share/fonts"
else
  FONT_DIR="$HOME/.local/share/fonts"
  mkdir -p "${FONT_DIR}"
fi

cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

install_fonts() {
  sudo dnf install -y "${CORE_NONFREE_FONTS[@]}"

  # Microsoft Fonts
  sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
  curl --output-dir "${TMP_DIR}" -fLO https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
  sudo rpm -ivh --nodigest --nofiledigest --force "${TMP_DIR}/msttcore-fonts-installer-2.6-1.noarch.rpm"

  # Donwload nerd fonts
  for font in "${NERD_FONTS}"; do
      curl --output-dir "${TMP_DIR}" -fLO "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.tar.xz"
      mkdir -p "${TMP_DIR}/${font}"
      tar -xJf "${TMP_DIR}/${font}.tar.xz" -C "${TMP_DIR}/${font}"
      cp -rf "${TMP_DIR}/${font}/" "${FONT_DIR}/"
  done

  # Refresh font cache
  fc-cache -f
}

install_fonts
