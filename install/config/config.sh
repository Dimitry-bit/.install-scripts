#!/usr/bin/env bash

set -euo pipefail

DUCKY_DIR_PATH="${HOME}/.local/share/ducky"

if [[ $(id -u) = 0 ]]; then
  echo "error: do not run this script as root." >&2
  exit 1
fi

mkdir -p ~/.config
cp -rf "${DUCKY_DIR_PATH}/config/"* ~/.config/
cp -rf "${DUCKY_DIR_PATH}/default/bashrc" ~/.bashrc
