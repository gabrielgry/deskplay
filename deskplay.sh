set -e
for installer in ~/.local/share/deskplay/tasks/applications/*.sh; do source "{$installer}"; done
