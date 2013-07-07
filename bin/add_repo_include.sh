#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Usage: $0 file repo_name"
	exit 0
fi

file=$1
repo=$2

new_path=$(dirname $file | sed 's/[^/]*/../g')
search_str="AdditionalIncludeDirectories.*$repo.*"
rep_str="s#\(AdditionalIncludeDirectories.*\)\"\$#\1\;$new_path/$repo/include\"#"

grep $search_str $file 2>&1 > /dev/null

if [ $? -eq 0 ]; then
	echo "found"
	exit 0
	cat $file | dos2unix | sed $rep_str | unix2dos
else 
	cat $file
fi


