#!/bin/bash

if [ $# -ne 1 ]; then 
	echo "Usage: $0 file_list"
	exit 0
fi

file_list=$1
tmp_dir=/tmp/translate_$$

#translate all the files
#for file in $(cat $file_list); do
#	dir=${tmp_dir}/$(dirname $file)
#	out_file=${dir}/$(basename $file)
#	mkdir -p $dir
#	~/bin/translate.pl $file > $out_file
#done

#for each translated file, see if the user wants to copy it
for file in $(cat $file_list); do
	if [ ! -f $file ]; then
		echo "no such file: $file"
		continue
	fi
	dir=${tmp_dir}/$(dirname $file)
	out_file=${dir}/$(basename $file)
	mkdir -p $dir
	~/bin/translate.pl $file > $out_file
	echo ""
	echo ""
	diff $file $out_file
	if [ $? -eq 0 ]; then
		#files are the same.
		echo "nothing for $file"
		continue
	fi
	echo "what to do with $file?"
	while /bin/true; do
		echo "	1) save new version"
		echo "	2) retain old version"
		read answer
		if [ $answer"" == "1" ]; then
			mv -f $out_file $file
			break
		elif [ $answer"" == "2" ]; then
			break
		fi
		echo "Unknown selection: $answer"
	done
done

rm -rf $tmp_dir
