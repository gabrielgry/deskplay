#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

VAULT_FOLDERS=(
  "Vault"
  "Vault/Archive"
  "Vault/Documents"
  "Vault/Media"
  "Vault/Projects"
  "Vault/Resources"
)

for folder in "${VAULT_FOLDERS[@]}"; do
  install -d -m700 "${HOME}/${folder}"

  if ! grep -qE "^file.*/${folder}" "${HOME}/.config/gtk-3.0/bookmarks"; then
    echo "file://${HOME}/${folder} ${folder}" >>"$HOME/.config/gtk-3.0/bookmarks"
  fi
done
