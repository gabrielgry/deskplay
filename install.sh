#!/bin/bash
set -euo pipefail

rm -rf ~/.local/share/deskplay

# mkdir ~/.local/share/deskplay
# cp -r ./* ~/.local/share/deskplay/
git clone https://github.com/gabrielgry/deskplay.git ~/.local/share/deskplay
git -C ~/.local/share/deskplay remote set-url origin git@github.com:gabrielgry/deskplay.git

chmod 744 ~/.local/share/deskplay/deskplay.sh

install -d ~/.local/bin
ln -sf ~/.local/share/deskplay/deskplay.sh ~/.local/bin/deskplay
