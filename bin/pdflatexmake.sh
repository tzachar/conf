#!/bin/bash

#Usage: latexmake file.tex line file.dvi

if [ $# -ne 1 ]; then
	echo "Usage: $0 line file-without.tex"
	exit 1
fi

pdflatex $1.tex

if [ $? -eq 0 ]; then
	evince $1.pdf &
fi


