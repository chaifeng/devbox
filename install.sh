#!/bin/bash
set -euo pipefail

ansible_version="2.8.0b1"

cd "${0%/*}"
PATH="$HOME/.local/bin:$PATH"
if ! ansible --version | grep -F "ansible $ansible_version"; then
  sudo apt update
  sudo apt install -y python3 python3-pip
  pip3 install ansible=="$ansible_version"
fi

declare -a ansible_opts=(-l localhost)
[[ -f private.yml ]] && ansible_opts+=(-e @private.yml)

sudo id "$USER"
ansible-playbook "${ansible_opts[@]}" ./devbox.yml "$@"
