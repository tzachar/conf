#!/bin/bash
for ff in *; do d=$(jhead $ff | grep Date/Time | cut -b 16-25 | sed 's/:/-/g');
	mkdir -p $d; mv $ff $d/; done
