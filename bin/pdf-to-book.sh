#!/bin/bash
set -e

# A script to make a document that after being
# printed two-sided with collation along the short edge,
# can be folded in the middle and makes a nice book.

if [ $# -lt 2 ]; then
  echo "Usage: $0 input-pdf output-pdf [page-ranges...]"
  echo "Example: $0 full.pdf two-col.pdf 10-110"
  exit 1
fi

cp "$1" "$1_cut.pdf"

if [ $# -gt 2 ]; then
    # Cut pages via pdftk (pdfxup -p sometimes produces an empty file).
    pdftk "$1_cut.pdf" cat "${@:3}" output "$1_cut.pdf"
fi

# -m 0pt option produces every second page empty

pdfxup -bb 20 -b se -o "$2" -im 15pt -fw 0pt "$1_cut.pdf"
rm "$1_cut.pdf"