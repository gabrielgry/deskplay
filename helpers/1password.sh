#!/bin/bash
set -euo pipefail

1password_ensure_signin() {
  local first_attempt=1

  while [ -z "$(op account list 2>/dev/null)" ]; do
    echo "Sign in to your 1Password account."
    echo "Ensure that CLI integration is enabled."

    if [ $first_attempt -eq 1 ]; then
      nohup 1password &>/dev/null &
      first_attempt=0
    fi

    sleep 5
    echo "Trying again"
  done

  echo "1Password is ready."
}
