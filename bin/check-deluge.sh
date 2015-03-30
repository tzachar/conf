#!/bin/bash

PRG=deluged
PID=$(pgrep $PRG)
LOG=/tmp/deluge-log

if [ ${PID:=""} = "" ]; then
	echo $(date)": restarting deluged" >> $LOG
	deluged --port=58846 &
else
	echo $(date)": deluge is running. pid: " ${PID} >> $LOG
fi
