#!/bin/bash

$player "$file"
file=$(\ls /home/tzachar/Media/Kofiko/* | sort -R | head -1)

play "$file"
