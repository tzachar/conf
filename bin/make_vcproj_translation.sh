#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: $0 new_file_list"
	exit 0
fi

for ff in $(cat $1); do
	file=$(basename $ff)
	link=$(echo $ff| sed 's#/#\\#g')
	echo "'$file'	=> '$link',"
done

