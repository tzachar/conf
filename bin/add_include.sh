#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Usage: $0 file include_dir"
	exit 0
fi

file=$1
inc=$2

rep_str="s#\(AdditionalIncludeDirectories.*\)\"\$#\1\;$2\"#"

cat $file | dos2unix | sed $rep_str | unix2dos


