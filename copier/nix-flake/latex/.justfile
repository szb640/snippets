#!/usr/bin/env -S just --justfile

project_root := justfile_directory()

[private]
default:
    @just --list

alias c := clean
clean:
    make clean

alias b := build
build:
    #!/usr/bin/env bash
    make all
