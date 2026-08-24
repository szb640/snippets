#!/usr/bin/env -S just --justfile

project_root := justfile_directory()

[private]
default:
    @just --list

alias a := apply
# Run playbook
apply playbook="":
    @ ./scripts/apply.sh '{{playbook}}'
