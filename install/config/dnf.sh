#!/usr/bin/env bash

set -euo pipefail

readonly DNF_OPTIONS=(
  defaultyes=True
  keepcache=True
)

if ! [[ $(id -u) = 0 ]]; then
  echo "Run this script using sudo." >&2
  exit 1
fi

for option in "${DNF_OPTIONS[@]}"; do
  if ! grep "${option}" "/etc/dnf/dnf.conf" &>/dev/null; then
    echo "${option}" >>"/etc/dnf/dnf.conf"
  fi
done
