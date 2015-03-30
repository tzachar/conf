#!/bin/sh 
	
links2 -dump  \
	'http://www.dictionary.com/search?q='$1'&r=67'\
         | tail -n +22 | less -r
