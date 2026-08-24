#!/usr/bin/env bash
set -euo pipefail

playbook=${1:-}

if [[ $# -eq 0 || -z "$playbook" ]]; then
    find ./playbooks -maxdepth 1 -type f \( -name "*.yml" -o -name "*.yaml" \) -print0 |
        xargs -0 -n1 basename |
        sed -E 's/\.(ya?ml)$//'
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
requirement_file="$SCRIPT_DIR/../requirements.yml"
if [[ -e "$requirement_file" ]]; then
    sentinel_file="$SCRIPT_DIR/../build/ansible-req"
    if [[ ! -e "$sentinel_file" || "$sentinel_file" -ot "$requirement_file" ]]; then
        >&2 echo "Updating requirements..."
        ansible-galaxy install -r "$requirement_file"
        mkdir -p "$SCRIPT_DIR/../build"
        touch "$sentinel_file"
    fi
fi

>&2 echo "Running playbook ${playbook}..."
ansible-playbook playbooks/${playbook}.yml
