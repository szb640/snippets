#!/usr/bin/env -S just --justfile

project_root := justfile_directory()

[private]
default:
    @just --list

alias b := build
build:
    #!/usr/bin/env bash
    cd src
    for tex_file in *.tex; do
      base_name="${tex_file%.tex}"
      pdf_file="${base_name}.pdf"
      if [[ ! -f "$pdf_file" || "$tex_file" -nt "$pdf_file" ]]; then
        echo "Compiling $tex_file..."
        lualatex -interaction=nonstopmode -synctex=1 "$tex_file"
        rm -f "${base_name}.aux" "${base_name}.log" "${base_name}.out" "${base_name}.synctex.gz"
      else
        echo "$tex_file is already up-to-date."
      fi
    done
