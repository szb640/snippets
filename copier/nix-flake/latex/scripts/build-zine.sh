#!/usr/bin/env bash
set -euxo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$SCRIPT_DIR/common.sh"
mkdir -p "${INTERMEDIATE_DIR}" "${FINAL_DIR}"
base_path="$1"
base_path="${base_path%.pdf}"
base_name="${base_path##*/}"
cat <<EOF | pdflatex -output-directory=${INTERMEDIATE_DIR} -jobname="${base_name}-zine-1"
\documentclass[a4paper]{article}
\usepackage[final]{pdfpages}
\usepackage[margin=0pt]{geometry}
\begin{document}
\includepdf[pages={1,8,7,6}, fitpaper=true, angle=180]{${base_path}}
\includepdf[pages={2,3,4,5}, fitpaper=true]{${base_path}}
\end{document}
EOF
rm "${INTERMEDIATE_DIR}/${base_name}-zine-1.log" "${INTERMEDIATE_DIR}/${base_name}-zine-1.aux"
zine_source="${INTERMEDIATE_DIR}/${base_name}-zine-1"
cat <<EOF | pdflatex -output-directory=${INTERMEDIATE_DIR} -jobname="${base_name}-zine"
\documentclass[a4paper]{article}
\usepackage[margin=0pt]{geometry}
\usepackage[final]{pdfpages}
\begin{document}
\includepdf[pages=-, nup=4x2, landscape]{$zine_source}
\end{document}
EOF
rm "${INTERMEDIATE_DIR}/${base_name}-zine-1.pdf" "${INTERMEDIATE_DIR}/${base_name}-zine.log" "${INTERMEDIATE_DIR}/${base_name}-zine.aux"
mv "${INTERMEDIATE_DIR}/${base_name}-zine.pdf" "${FINAL_DIR}/"
rmdir "${INTERMEDIATE_DIR}"
