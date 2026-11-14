#!/usr/bin/env bash
# Compile each written exercise into a problem-set PDF and a solution PDF.
#
# Usage: ./compile.sh [N ...]     (default: all src/ex_*.tex)
#
# Output: pdfs/exercise_N_questions.pdf and pdfs/exercise_N_solutions.pdf
# (exercises are numbered from 0).
# The preamble is taken from src/main.tex; the solution toggle (\showSolution)
# decides whether \solution{...} blocks are printed.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$ROOT_DIR/src"
OUT_DIR="$ROOT_DIR/pdfs"
BUILD_DIR="$ROOT_DIR/build"
TEX_DIR="$BUILD_DIR/tex"    # generated wrapper .tex files
AUX_DIR="$BUILD_DIR/aux"    # LaTeX intermediate files (.aux, .log, .pdf, ...)

# Run from SRC_DIR so \input{ex_N} and fig/ paths resolve.
cd "$SRC_DIR"
mkdir -p "$TEX_DIR" "$AUX_DIR"

if [ "$#" -gt 0 ]; then
  exercises=("$@")
else
  exercises=($(ls ex_*.tex | sed -E 's|ex_([0-9]+)\.tex|\1|' | sort -n))
fi

# Everything in main.tex before \begin{document}
preamble="$(sed '/\\begin{document}/,$d' main.tex)"

build() {
  local n="$1" show="$2" name="$3"
  local tex="$TEX_DIR/$name.tex"
  {
    printf '%s\n' "$preamble"
    printf '\\begin{document}\n'
    printf '\\pagenumbering{gobble}\n'
    printf '\\setcounter{Exercise}{%s}\n' "$n"
    printf '\\showSolution%s\n' "$show"
    printf '\\printexercise{ex_%s}\n' "$n"
    printf '\\end{document}\n'
  } > "$tex"

  if ! latexmk -pdf -interaction=nonstopmode -halt-on-error \
       -outdir="$AUX_DIR" "$tex" > "$AUX_DIR/$name.stdout" 2>&1; then
    echo "  FAILED: $name (see $AUX_DIR/$name.log)" >&2
    return 1
  fi

  mkdir -p "$OUT_DIR"
  cp "$AUX_DIR/$name.pdf" "$OUT_DIR/$name.pdf"
  echo "  -> pdfs/$name.pdf"
}

status=0
for n in "${exercises[@]}"; do
  if [ ! -f "ex_${n}.tex" ]; then
    echo "Exercise $n: src/ex_${n}.tex not found, skipping" >&2
    status=1
    continue
  fi
  echo "Exercise $n"
  build "$n" false "exercise_${n}_questions" || status=1
  build "$n" true "exercise_${n}_solutions" || status=1
done

exit $status
