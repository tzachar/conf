#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: $0 new_file_list"
	exit 0
fi

for ff in $(cat $1); do
	file=$(basename $ff)
	echo "'$file'	=> '$ff',"
done

