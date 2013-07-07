#!/bin/bash

echo "fixing include directories for repo $(basename $PWD)"
rm -rf include
mkdir include

#for dir in $(cat $config); do
for dir in $(find  * -mindepth 1 -type d  | grep 'include/[^/]*$'); do
	target=$(basename $dir)
	ln -s -T ../$dir include/$target
	echo "created link to $dir"
done
