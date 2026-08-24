#!/usr/bin/env bash
set -euxo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$SCRIPT_DIR/common.sh"
mkdir -p "${INTERMEDIATE_DIR}" "${FINAL_DIR}"
base_path="$1"
base_path="${base_path%.pdf}"
base_name="${base_path##*/}"
cat <<EOF | pdflatex -output-directory=${INTERMEDIATE_DIR} -jobname="${base_name}-a4"
\documentclass{article}
\usepackage[a4paper]{geometry}
\usepackage{pdfpages}
\begin{document}
\includepdf[pages=-,nup=2x2,frame,noautoscale]{$base_path}
\end{document}
EOF
rm -f "${INTERMEDIATE_DIR}/${base_name}-a4.log" "${INTERMEDIATE_DIR}/${base_name}-a4.aux"
mv "${INTERMEDIATE_DIR}/${base_name}-a4.pdf" "${FINAL_DIR}/"
rmdir "${INTERMEDIATE_DIR}"
