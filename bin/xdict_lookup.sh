#!/bin/bash

#WORD=$(~/bin/xgetselection)
WORD=$(xsel)

echo $WORD
xterm -geometry 80x10 -e ~/bin/dict-lookup.sh $WORD
