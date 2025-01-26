rpm_ostree_override_remove() {
  local packages=("$@") 

  for package in "${packages[@]}"; do
    if ! rpm-ostree status --json | jq -e ".deployments[0][\"requested-base-removals\"][] | select(. == \"$package\")" > /dev/null 2>&1; then
      sudo rpm-ostree override remove "$package"
    fi
  done
}

