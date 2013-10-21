#!/bin/bash

#Usage: latexmake file.tex line file.dvi

if [ $# -ne 2 ]; then
	echo "Usage: $0 line file-without.tex"
	exit 1
fi

latex $2.tex

if [ $? -eq 0 ]; then
	xdvi -s 4 -name $2.vimdvi -sourceposition "$1$2.tex" $2.dvi -bg white
fi


