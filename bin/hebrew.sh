#!/bin/bash

if [ $# -gt 0 ]; then 
	setxkbmap -option
else 
	setxkbmap -option grp:switch,grp:ctrl_shift_toggle,grp_led:scroll us,il
fi
