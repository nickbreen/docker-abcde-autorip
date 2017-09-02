FROM phusion/baseimage

COPY local.pref /etc/apt/preferences.d/
RUN apt-get update && apt-get install -y abcde cdparanoia lame eyed3 eject imagemagick glyrc normalize-audio beep flac inotify-tools && apt-get clean 
COPY autorip.sh /etc/service/autorip/run
COPY autoencode.sh /etc/service/autoencode/run
COPY abcde.conf /etc/abcde.conf
