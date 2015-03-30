#!/bin/bash

$player "$file"
file=$(\ls /home/tzachar/Media/The\ Wi*/* | sort -R | head -1)

play  "$file" 

