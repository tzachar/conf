#!/bin/bash

dir=/home/tzachar/Media/Hayo.Haya

file=$(\ls ${dir}/* | sort -R | head -1)

play "$file"
