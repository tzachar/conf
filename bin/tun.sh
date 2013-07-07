#!/bin/bash

while /bin/true; do
	su -l -c "ssh -R 8080:localhost:22 172.30.35.223 -N" tzachar
	sleep 10
done
