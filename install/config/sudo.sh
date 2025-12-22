#!/usr/bin/env bash

# Ask for sudo password once per tty.

set -euo pipefail

readonly POLICY_FILE_PATH="/etc/sudoers.d/99-disable-tty-tickets"
readonly TMP_FILE="$(mktemp)"

cleanup() {
  rm "${TMP_FILE}"
}
trap cleanup EXIT

echo "Defaults !tty_tickets" >"${TMP_FILE}"

if visudo --check -f "${TMP_FILE}" &>/dev/null; then
  cp "${TMP_FILE}" "${POLICY_FILE_PATH}"
else
  echo "error: Invalid sudoers syntax; aborting" >&2
  exit 1
fi
