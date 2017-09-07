FROM phusion/baseimage

COPY local.pref /etc/apt/preferences.d/
RUN apt-get update && apt-get install -y abcde cdparanoia lame eyed3 eject imagemagick glyrc normalize-audio beep flac mkcue && apt-get clean 
COPY autorip.sh /usr/local/bin/
COPY abcde.conf /etc/abcde.conf
CMD /sbin/my_init -- /usr/local/bin/autorip.sh
ENV CDROM=/dev/cdrom OUTPUTDIR=/srv