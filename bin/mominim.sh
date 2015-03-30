#!/bin/bash
. player.sh

file=$(\ls /home/tzachar/Media/Mominim/* | sort -R | head -1)

play "$file"
