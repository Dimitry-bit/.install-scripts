#!/usr/bin/env bash

set -euo pipefail

CORE_NONFREE_FONTS=(
  google-roboto-fonts
  google-arimo-fonts
  google-cousine-fonts
  google-tinos-fonts
  google-noto-sans-arabic-fonts
)

NERD_FONTS=(
   JetBrainsMono
)

FONT_DIR="${HOME}/.local/share/fonts"

TMP_DIR="$(mktemp -d)"

trap 'rm -rf "${TMP_DIR}"' EXIT

if [[ $(id -u) = 0 ]]; then
    echo "error: do not run this script as root." >&2
    exit 1
fi

install_fonts() {
  sudo dnf install -y "${CORE_NONFREE_FONTS[@]}"

  # Microsoft Fonts
  sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
  curl --output-dir "${TMP_DIR}" -fLO https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
  sudo rpm -ivh --nodigest --nofiledigest --force "${TMP_DIR}/msttcore-fonts-installer-2.6-1.noarch.rpm"

  # Download nerd fonts
  for font in "${NERD_FONTS}"; do
      curl --output-dir "${TMP_DIR}" -fLO "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.tar.xz"
      mkdir -p "${TMP_DIR}/${font}"
      tar -xJf "${TMP_DIR}/${font}.tar.xz" -C "${TMP_DIR}/${font}"
      cp -rf "${TMP_DIR}/${font}/" "${FONT_DIR}/"
  done

  # Refresh font cache
  fc-cache -f "${FONT_DIR}"
}

install_fonts
