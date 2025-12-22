#!/usr/bin/env bash

set -euo pipefail

mkdir -p ~/.config
cp -rf ~/.local/share/ducky/config/* ~/.config/
cp -rf ~/.local/share/ducky/default/bashrc ~/.bashrc
