#!/bin/bash

if [ $# -ne 4 ]; then 
	echo "Usage: $0 vcproj_list old_dir_name new_dir_name repo_name"
	exit 0
fi

file_list=$1
old_dir_name=$2
new_dir_name=$3
repo_name=$4
tmp_dir=/tmp/translate_$$

#translate all the files
for file in $(cat $file_list); do
	dir=${tmp_dir}/$(dirname $file)
	out_file=${dir}/$(basename $file)
	mkdir -p $dir
	go_back_to_repos_dir=$(dirname $file | sed 's/[^/]*/../g')
	repo_include_path=${go_back_to_repos_dir}/$repo_name/${new_dir_name}/include
	global_include_path=${go_back_to_repos_dir}/$repo_name/include
	~/bin/remove_include.sh $file $old_dir_name > ${out_file}.tmp
	~/bin/add_include.sh ${out_file}.tmp $global_include_path > ${out_file}.tmp1
	~/bin/add_include.sh ${out_file}.tmp1 $repo_include_path > ${out_file}
	#~/bin/switch_include.sh ${out_file}.tmp $old_dir_name $global_include_path > ${out_file}
done

#for each translated file, see if the user wants to copy it
fast_forward="no"
for file in $(cat $file_list); do
	dir=${tmp_dir}/$(dirname $file)
	out_file=${dir}/$(basename $file)
	if [ $fast_forward == "yes" ]; then
		echo "copying new version of $file"
		mv -f $out_file $file
		continue
	fi
	echo ""
	echo ""
	echo "what to do with $file?"
	diff $file $out_file
	if [ $? -eq 0 ]; then
		#files are the same.
		echo "No change for $file"
		continue
	fi
	while [ $fast_forward == "no" ]; do
		echo "	1) save new version"
		echo "	2) retain old version"
		echo "	3) save new version (for all. do not ask)"
		read answer
		if [ $answer"" == "1" ]; then
			mv -f $out_file $file
			break
		elif [ $answer"" == "3" ]; then
			mv -f $out_file $file
			fast_forward="yes"
			break
		elif [ $answer"" == "2" ]; then
			break
		fi
		echo "Unknown selection: $answer"
	done
done

rm -rf $tmp_dir
