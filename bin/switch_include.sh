#!/bin/bash

if [ $# -ne 3 ]; then
	echo "Usage: $0 file old_include_dir new_include_dir"
	exit 0
fi

file=$1
inc=$2
new_inc=$3

rep_str="s#\(AdditionalIncludeDirectories.*\);[^;]*[/\\]$inc#\1;$new_inc#"

cat $file | dos2unix | sed $rep_str | unix2dos


