#!/usr/bin/env -S just --justfile

project_root := justfile_directory()

[private]
default:
    @just --list
