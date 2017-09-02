FROM phusion/baseimage

COPY local.pref /etc/apt/preferences.d/
<<<<<<< HEAD
RUN apt-get update && apt-get install -y abcde cdparanoia lame eyed3 eject imagemagick glyrc normalize-audio beep && apt-get clean 
=======
RUN apt-get update && apt-get install -y abcde cdparanoia lame eyed3 eject imagemagick glyrc normalize-audio && apt-get clean 
>>>>>>> ddcea0aa5faec9cadcca448878cb8db783ae4be8
COPY autorip.sh /etc/service/autorip/run
COPY abcde.conf /etc/abcde.conf
