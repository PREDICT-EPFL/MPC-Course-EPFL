# Written exercises

LaTeX sources for the written exercises. Each exercise is compiled into two PDFs:
a problem set (questions only) and a solution sheet (questions with solutions in blue).

## Requirements

A LaTeX distribution that provides `latexmk` and `pdflatex`, e.g.
[MacTeX](https://www.tug.org/mactex/) on macOS or TeX Live (`texlive-full`) on Linux.

## Generating the PDFs

From this folder, run:

```bash
./compile.sh          # all exercises
./compile.sh 3 7      # only exercises 3 and 7
```

The PDFs are written to `pdfs/`:

- `pdfs/exercise_N_questions.pdf`: problem set N
- `pdfs/exercise_N_solutions.pdf`: problem set N with solutions

built from `src/ex_N.tex`. Exercises are numbered from 0 (0 to 9).

If an exercise fails to compile, the script prints `FAILED` with the path of
its LaTeX log in `build/aux/`.

## Folder layout

```
written_exercises/
├── compile.sh       # build script
├── src/
│   ├── main.tex         # shared preamble (packages, macros); also builds all exercises in one document
│   ├── ex_N.tex         # exercise N, with solutions wrapped in \solution{...}
│   ├── fig/             # figures used by the exercises
│   └── references.bib
├── pdfs/            # generated PDFs
└── build/           # intermediate files, safe to delete
    ├── tex/             # generated wrapper .tex files
    └── aux/             # .aux, .log, ... from latexmk
```

## How it works

`compile.sh` takes the preamble of `src/main.tex` and generates, for each
`src/ex_N.tex`, two small wrapper documents in `build/tex/`:

- one with `\showSolutionfalse`, so every `\solution{...}` is hidden, giving `exercise_N_questions.pdf`
- one with `\showSolutiontrue`, so solutions are shown, giving `exercise_N_solutions.pdf`

Both are compiled with `latexmk` from inside `src/`, so `\input` and `fig/...`
paths resolve relative to `src/`.

## Adding or editing an exercise

- Write the questions and solutions in a single file `src/ex_N.tex`, and
  wrap each solution in `\solution{...}`.
- Put any figures in `src/fig/` and include them as `fig/<name>.png`.
- New packages or macros go in the preamble of `src/main.tex`.
- Run `./compile.sh N` to build it; this writes `pdfs/exercise_N_*.pdf`.

To build all exercises into one combined document instead (each exercise
without and then with solutions), add `\exercise{ex_N}` to the
document body of `src/main.tex` and compile it from `src/`:

```bash
cd src && latexmk -pdf -outdir=../build/aux main.tex
```

The result is `build/aux/main.pdf`.
