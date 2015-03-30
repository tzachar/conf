#! /bin/bash

address="DC:2C:26:DA:56:B7"

while (sleep 1)
do
	connected=`hidd --show` > /dev/null
	if [[ ! $connected =~ .*${address}.* ]] ; then
		hidd --connect ${address} > /dev/null 2>&1
	fi
done

