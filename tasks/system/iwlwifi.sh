#!/bin/bash
set -euo pipefail

sudo bash -c "
cat >/etc/modprobe.d/iwlwifi.conf <<EOF
options iwlwifi 11n_disable=8
options iwlwifi power_save=0 
EOF
"
