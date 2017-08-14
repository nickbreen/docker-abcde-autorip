FROM phusion/baseimage

RUN apt-get update && apt-get install -y --no-install-recommends abcde cdparanoia lame eyed3 imagemagick glyrc && apt-get clean 
COPY autorip.sh /etc/service/autorip/run
COPY abcde.conf /etc/abcde.conf
VOLUME /dev/cdrom
