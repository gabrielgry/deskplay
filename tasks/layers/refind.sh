#!/bin/bash
set -euo pipefail

sudo rpm-ostree install rEFInd -y --apply-live --idempotent
sudo refind-install --yes
sudo refind-mkdefault
