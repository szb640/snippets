#!/usr/bin/env bash
set -euxo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$SCRIPT_DIR/common.sh"
mkdir -p "${INTERMEDIATE_DIR}" "${FINAL_DIR}"
base_name="$1"
base_name="${base_name##*/}"
base_name="${base_name%.*}"
lualatex --interaction=nonstopmode --synctex=1 "--output-directory=${INTERMEDIATE_DIR}" "$1"
rm -f "${INTERMEDIATE_DIR}/$base_name.aux" "${INTERMEDIATE_DIR}/$base_name.log" "${INTERMEDIATE_DIR}/$base_name.out" "${INTERMEDIATE_DIR}/$base_name.synctex.gz"
mv "${INTERMEDIATE_DIR}/$base_name.pdf" "${FINAL_DIR}/"
rmdir "${INTERMEDIATE_DIR}"
