#!/bin/bash


. player.sh
file=$(\ls /home/tzachar/Media/Smurfs/* | sort -R | head -1)

play "$file"
