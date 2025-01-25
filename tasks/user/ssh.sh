#!/bin/bash
set -euo pipefail

install -d -m700 ~/.ssh
install -m600 -t ~/.ssh ~/.local/share/deskplay/files/ssh/*
