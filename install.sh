#!/bin/bash
set -euo pipefail

ansible_version="2.8.0a1"

PATH="$HOME/.local/bin:$PATH"
if ! ansible --version | grep -F "ansible $ansible_version"; then
  sudo apt update
  sudo apt install -y python3 python3-pip
  pip3 install ansible=="$ansible_version"
fi

ansible-playbook -l localhost ./devbox.yml
