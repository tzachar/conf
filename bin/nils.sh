#!/bin/bash

file=$(\ls /home/tzachar/Media/Nils/* | sort -R | head -1)
$player "$file"

play "$file"
