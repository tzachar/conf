#!/bin/bash

#exec mplayer -ass  -subcp ISO-8859-8 -vc coreserve -nocorrect-pts \
	#-ass-force-style FontName=Arial\
. player.sh
play $@
exit 0

sub=""
if [ -f "$1" ]; then
	dir=$(dirname "$1")
	file="${1%\.*}"
	tmp="$dir/$file.srt"
	echo $tmp
	if [ -f "$tmp" ]; then
		sub="-sub \"$tmp\""
	fi
fi

#exec /home/tzachar/mplayer/bin/mplayer -subcp ISO-8859-8 -nocorrect-pts \
exec mplayer -subcp ISO-8859-8 -nocorrect-pts \
	-af volume=10.1:0 \
	-vfm ffmpeg \
	-lavdopts skiploopfilter=none:threads=4\
	-ao alsa \
	-flip-hebrew \
	"$@"
#exec mplayer -vc coreserve -demuxer lavf -nocorrect-pts "$@"
