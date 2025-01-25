#!/bin/bash
set -euo pipefail

KEY_FOLDER='/etc/pki/rpm-gpg'
KEY_FILENAME='1password.asc'

REPO_FOLDER='/etc/yum.repos.d'
REPO_FILE='1password.repo'

TMP_FOLDER="$(mktemp -d)"

curl -o "${TMP_FOLDER}/${KEY_FILENAME}" "https://downloads.1password.com/linux/keys/1password.asc"
sudo install -o 0 -g 0 -m644 "${TMP_FOLDER}/${KEY_FILENAME}" "${KEY_FOLDER}/${KEY_FILENAME}"

cat >"${TMP_FOLDER}/${REPO_FILE}" <<EOF
[1password]
name=1Password Stable Channel
baseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=file://${KEY_FOLDER}/${KEY_FILENAME}
EOF
sudo install -o 0 -g 0 -m644 "${TMP_FOLDER}/${REPO_FILE}" "${REPO_FOLDER}/${REPO_FILE}"

sudo rpm-ostree install 1password 1password-cli -y --idempotent

# Install autostart file
install -m755 -d ~/.config/autostart
install -m744 -t ~/.config/autostart ~/.local/share/deskplay/files/1password/1password.desktop

# Install config files
install -m700 -d ~/.config/1Password
install -m700 -d ~/.config/1Password/{settings,ssh}
install -m600 -t ~/.config/1Password/settings ~/.local/share/deskplay/files/1password/config/settings/settings.json
install -m600 -t ~/.config/1Password/ssh ~/.local/share/deskplay/files/1password/config/ssh/agent.toml

rm -r "${TMP_FOLDER}"
