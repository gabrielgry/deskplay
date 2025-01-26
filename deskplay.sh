#!/bin/bash
set -euo pipefail

script_dir=$(dirname "$(realpath "$0")")

# Enable debugging if --debug is provided as an argument
if [[ "$*" == *--debug* ]]; then
  set -xv
  # Remove --debug from the arguments list to avoid issues with subcommands
  set -- "${@/--debug/}"
fi

deskplay_pre_setup() {
  echo "Running pre-setup tasks..."
  for installer in ~/.local/share/deskplay/tasks/pre-setup/*.sh; do source "$installer"; done

  systemctl reboot
}

# Define the deskplay CLI functions
deskplay_run() {
  echo "Running DNF repositories tasks..."
  for installer in ~/.local/share/deskplay/tasks/repos/*.sh; do source "$installer"; done
  echo "Running system tasks..."
  for installer in ~/.local/share/deskplay/tasks/system/*.sh; do source "$installer"; done
  echo "Running layers tasks..."
  for installer in ~/.local/share/deskplay/tasks/layers/*.sh; do source "$installer"; done
  echo "Running applications tasks..."
  for installer in ~/.local/share/deskplay/tasks/applications/*.sh; do source "$installer"; done
  echo "Running Gnome tasks..."
  for installer in ~/.local/share/deskplay/tasks/gnome/*.sh; do source "$installer"; done
  echo "Running user tasks..."
  for installer in ~/.local/share/deskplay/tasks/user/*.sh; do source "$installer"; done

  systemctl reboot
}

deskplay_post_setup() {
  echo "Running scripts post-reboot after configuration..."
  for installer in ~/.local/share/deskplay/tasks/post-setup/*.sh; do source "$installer"; done

  systemctl reboot
}

deskplay_edit() {
  echo "Opening Deskplay for editing..."
  ${EDITOR:-nano} "$script_dir"
}

deskplay_pull() {
  echo "Pulling latest changes from origin..."
  git -C "$script_dir" pull origin
}

deskplay_push() {
  echo "Pushing changes to origin..."
  git -C "$script_dir" push origin
}

# Main CLI dispatcher
case "$1" in
pre-setup)
  deskplay_pre_setup
  ;;
run)
  deskplay_run
  ;;
post-setup)
  deskplay_post_setup
  ;;
edit)
  shift
  deskplay_edit "$@"
  ;;
pull)
  deskplay_pull
  ;;
push)
  deskplay_push
  ;;
*)
  echo "Usage: $0 {run|post-setup|edit|pull|push}  [--debug]"
  exit 1
  ;;
esac
