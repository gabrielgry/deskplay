#!/bin/bash
set -euo pipefail

source ~/.local/share/deskplay/helpers/1password.sh

install -d -m700 ~/.config/git

1password_ensure_signin

cat >~/.config/git/config <<EOF
[gpg]
  format = ssh

[gpg "ssh"]
  program = /opt/1Password/op-ssh-sign

[commit]
  gpgsign = true

[user]
  signingKey = $(op read "op://Developer/Github SSH Auth/public key")
  name = $(op read "op://Developer/Github/Security/name")
  email = $(op read "op://Developer/Github/username")
EOF

chmod 600 ~/.config/git/config
