#!/bin/bash
set -euo pipefail

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify --no-filter --enable flathub

if flatpak remotes --columns=name | grep -qw "fedora"; then
  apps="$(flatpak list --app-runtime=org.fedoraproject.Platform --columns=application | tail -n +1)"
  if [[ -n "$apps" ]]; then
    sudo flatpak install --noninteractive -y --reinstall flathub $apps
  fi
  sudo bash -c "yes | flatpak remote-delete fedora"
fi

flatpak_apps=(
  "com.spotify.Client"
  "ca.desrt.dconf-editor"
  "org.qbittorrent.qBittorrent"
  "org.gnome.Showtime"
  "com.github.xournalpp.xournalpp"
  "org.gnome.Extensions"
)

for app in "${flatpak_apps[@]}"; do
  if ! flatpak list --columns=application | grep -w "$app"; then
    flatpak install flathub "$app" -y
  fi
done
