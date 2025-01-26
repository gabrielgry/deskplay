#!/bin/bash
set -euo pipefail

# Add remotes
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify --no-filter --enable flathub

# Remove unused Flatpaks
flatpaks_to_remove=(
  "org.gnome.Weather"
  "com.google.Chrome"
  "org.fedoraproject.MediaWriter"
  "org.gnome.Calendar"
  "org.gnome.Connections"
  "org.gnome.Contacts"
  "org.gnome.Maps"
  "org.gnome.clocks"
)

for app in "${flatpaks_to_remove[@]}"; do
  if flatpak list --columns=application | grep -w "$app"; then
    flatpak uninstall flathub "$app" -y --noninteractive --delete-data
  fi
done

# Reinstall Flatpaks from the Fedora remote to the Flathub remote
if flatpak remotes --columns=name | grep -qw "fedora"; then
  apps="$(flatpak list --app-runtime=org.fedoraproject.Platform --columns=application | tail -n +1)"
  if [[ -n "$apps" ]]; then
    sudo flatpak install --noninteractive -y --reinstall flathub $apps
  fi
  sudo bash -c "yes | flatpak remote-delete fedora"
fi

# Install Flatpaks
flatpaks_to_install=(
  "com.spotify.Client"
  "ca.desrt.dconf-editor"
  "org.qbittorrent.qBittorrent"
  "org.gnome.Showtime"
  "com.github.xournalpp.xournalpp"
  "org.gnome.Extensions"
)

for app in "${flatpaks_to_install[@]}"; do
  if ! flatpak list --columns=application | grep -w "$app"; then
    flatpak install flathub "$app" -y --noninteractive
  fi
done

#Fix qBittorrent dark theme
sudo flatpak override --env=GTK_THEME=Adwaita:dark org.qbittorrent.qBittorrent
