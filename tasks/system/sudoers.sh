#!/bin/bash
set -euo pipefail

echo 'Defaults pwfeedback' | sudo EDITOR='tee' visudo -f /etc/sudoers.d/99_pwfeedback
