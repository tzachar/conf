#!/bin/bash

exec /home/tzachar/mplayer/bin/mplayer -ontop -fs -ao alsa -vf pp=vb:a/hb:a/lb,hqdn3d "$@"
