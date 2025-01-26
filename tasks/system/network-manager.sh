#!/bin/bash
set -euo pipefail

sudo bash -c "
cat >/etc/NetworkManager/conf.d/wifi-powersave-off.conf <<EOF
[connection]
wifi.powersave = 2
802-11-wireless.powersave = 2
EOF
"
