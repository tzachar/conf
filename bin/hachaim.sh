#!/bin/bash

. player.sh
dir=/home/tzachar/Media/Hachayim

file=$(find ${dir} -type f| sort -R | head -1)

play "$file"
