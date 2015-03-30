#!/bin/bash

. player.sh
file=$(find ~/Media/Mr.Bean.animated -type f | sort -R | head -1)

play "$file"
