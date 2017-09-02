#!/bin/bash

. /etc/container_environment.sh

LOGDEST=${LOGDEST:-user}
OUTPUTDIR=${OUTPUTDIR:-/srv/mp3}
FLAC_PATTERN="*.flac"

# Set up syslog-ing
exec 1> >(logger ${LOGDEST:+-p ${LOGDEST}.info}) 2> >(logger ${LOGDEST:+-p ${LOGDEST}.warn})
# Wait for syslog
sv -w 5 up syslog-ng

# Wait for files to be closed after writing
inotifywait -mr --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' -e close_write ${SRC:-/srv/flac} | while read DATE TIME DIR FILE; do
	if [[ "$FILE" == "$FLAC_PATTERN" ]]
	then
		echo Transcoding $DATE $TIME $DIR $FILE
		abcde -V -Nx -d ${DIR}${FILE}
	else
		echo Ignoring $DATE $TIME $DIR $FILE not $FLAC_PATTERN >&2
	fi
done
