#!/bin/bash

. /etc/container_environment.sh

CDROM=${CDROM:-/dev/cdrom}
OUTPUTDIR=${OUTPUTDIR:-/srv/flac}
LOGDEST=${LOGDEST:-user}
# Set up syslog-ing
exec 1> >(logger ${LOGDEST:+-p ${LOGDEST}.info}) 2> >(logger ${LOGDEST:+-p ${LOGDEST}.warn})
# Wait for syslog
sv -w 5 up syslog-ng
# Okay, abcde has a bug where it tries to rip data cd's. But the version that fixes it itself has
# even more. So instead of trying to install the new version, which doesn't work, we use a command
# similar to the one ABCDE uses to determine the number of valid tracks (since it assumes the data
# track always occurs at the end, which in some game CD's it doesn't) and pass it to the command
# line. Yes, it really is one line.
VALIDTRACKS="$(cdparanoia -d $CDROM -Q | egrep '^[[:space:]]+[[:digit:]]' | awk '{print $1}' | tr -d "." | tr '\n' ' ')"
# Do it. Do it.	
DISC=$(cd-discid $CDROM)
echo Ripping ${DISC}
abcde -V -Nx -d $CDROM -1 -o flac -a default,cue $VALIDTRACKS
