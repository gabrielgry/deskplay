#!/bin/bash
set -euo pipefail

# If GNOME Extension CLI is not already installed, use Toolbox to install it
if ! which gext &>/dev/null; then
  if [ -z "$(toolbox list -c | awk -v name="deskplay" '$2 == name')" ]; then
    toolbox create deskplay -y
  fi

  toolbox run -c deskplay sudo dnf install pipx -y
  toolbox run -c deskplay pipx install gnome-extensions-cli --system-site-packages --include-deps
fi

# Install extensions
gext install \
  appindicatorsupport@rgcjonas.gmail.com \
  BingWallpaper@ineffable-gmail.com

# Compile the schemmas in order to use them set them gsettings
install -d -m755 ~/.local/share/glib-2.0/schemas
cp ~/.local/share/gnome-shell/extensions/BingWallpaper@ineffable-gmail.com/schemas/org.gnome.shell.extensions.bingwallpaper.gschema.xml ~/.local/share/glib-2.0/schemas/
cp ~/.local/share/gnome-shell/extensions/appindicatorsupport@rgcjonas.gmail.com/schemas/org.gnome.shell.extensions.appindicator.gschema.xml ~/.local/share/glib-2.0/schemas/
glib-compile-schemas ~/.local/share/glib-2.0/schemas/

# Configure Bing Wallpaper
gsettings set org.gnome.shell.extensions.bingwallpaper download-folder "'$HOME/Vault/Archive/Wallpapers/BingWallpaper'"
gsettings set org.gnome.shell.extensions.bingwallpaper market 'pt-BR'
gsettings set org.gnome.shell.extensions.bingwallpaper resolution 'UHD'
