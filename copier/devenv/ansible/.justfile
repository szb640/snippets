#!/usr/bin/env -S just --justfile

project_root := justfile_directory()

[private]
default:
    @just --list

alias a := apply
apply tags="":
    #!/usr/bin/env bash
    command="ANSIBLE_DEBUG=1 ansible-playbook playbooks/site.yml"
    if [ -n '{{tags}}' ]; then
      command+=" --tag {{tags}}"
    fi
    echo $command
    eval $command
