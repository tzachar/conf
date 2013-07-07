#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Usage: $0 line file-without.tex"
	exit 1
fi

latex -src-specials $2.tex

if [ $? -eq 0 ]; then
	#xdvi -s 4 $2.dvi -bg white -unique -sourceposition "$1$2.tex"
	xdvi -s 4 $2.dvi -bg white -fg black -cr black -sourceposition "$1$2.tex"

	#xdvi -s 4 -name $2.vimdvi -sourceposition "$1$2.tex" $2.dvi -bg white 
fi
