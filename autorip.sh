#!/bin/bash -e
. /etc/container_environment.sh
while ! sv -w 5 up syslog-ng >&- 2>&-
do
	sleep 5 # Wait a bit for syslog to start
done
exec 1> >(logger -t autorip) 2> >(logger -e  -t autorip)
# Do it. Do it.	
abcde -N -d $CDROM -P
