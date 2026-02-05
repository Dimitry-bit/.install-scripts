#!/usr/bin/env bash

# Ask for sudo password once per tty.

set -euo pipefail

POLICY_FILE_PATH="/etc/sudoers.d/99-disable-tty-tickets"
TMP_FILE="$(mktemp)"

trap 'rm -f "${TMP_FILE}"' EXIT

echo "Defaults !tty_tickets" >> "${TMP_FILE}"
if ! visudo --check -f "${TMP_FILE}" &>/dev/null; then
    echo "error: invalid sudoers syntax; aborting" >&2
    exit 1
fi
sudo install -o root -g root -m 0440 "${TMP_FILE}" "${POLICY_FILE_PATH}"

visudo --check &>/dev/null
