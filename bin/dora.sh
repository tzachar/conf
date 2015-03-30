#!/bin/bash

. player.sh

file=$(\ls /home/tzachar/Media/Dora/* | sort -R | head -1)

play "$file"
