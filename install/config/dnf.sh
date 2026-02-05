#!/usr/bin/env bash

set -euo pipefail

DNF_CONF_PATH="/etc/dnf/dnf.conf"

set_option() {
    local key="$1"
    local value="$2"

    if sudo grep -qE "^\s*${key}\s*=" "${DNF_CONF_PATH}"; then
        sudo sed -i "s/^\s*${key}\s*=.*/${key}=${value}/g" "${DNF_CONF_PATH}"
    else
        echo "${key}=${value}" | sudo tee --append "${DNF_CONF_PATH}" >/dev/null
    fi
}

set_option "defaultyes" "True"
set_option "keepcache" "True"
