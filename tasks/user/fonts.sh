#!/bin/bash
set -euo pipefail

TEMPDIR="$(mktemp -d)"

wget -O "${TEMPDIR}/jetbrains-mono.tar.xz" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
install -d ~/.local/share/fonts/nerd-fonts/jetbrains-mono
tar -xf "${TEMPDIR}/jetbrains-mono.tar.xz" -C ~/.local/share/fonts/nerd-fonts/jetbrains-mono

fc-cache

rm -r "${TEMPDIR}"
