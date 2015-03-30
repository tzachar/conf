#!/bin/bash 

if [ $# -lt 2 ]; then
	echo "Usage: $0 torrent_file tracker"
	exit 1
fi

TOR=$1
N=$2

cp $TOR $TOR.org

TRACKER=$(btshowmetainfo.py $TOR | grep "announce url" | cut -f3 -d' ')
LIST=$(btshowmetainfo.py $TOR | grep "announce-list" | \
	cut -f2 -d' ' | sed 's/|/,/g')

echo $TRACKER
echo $LIST

btreannounce.py "$TRACKER" --announce_list "$LIST,$N" $TOR
