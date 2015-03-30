#!/bin/bash

curl -o /tmp/$$.html http://192.168.1.102 2&>1 > /dev/null
idle_count=$(grep 'Call 1 State' /tmp/$$.html | cut -b-150 | grep Idle | wc -l)

if [[ $idle_count -ne 2 ]]; then
	echo "on!"
else
	curl -o /dev/null http://192.168.1.102/admin/reboot 2&>1 /dev/null
fi

rm /tmp/$$.html
