FROM ubuntu:xenial

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-suggests -y abcde cdparanoia lame eyed3 imagemagick glyrc gunzip && apt-get clean 
ARG UID=1000
ARG GID
ARG LOGIN=autorip
RUN useradd -o -u ${UID} ${GID:+-g ${GID}} $LOGIN
USER ${LOGIN}
CMD gunzip /usr/share/doc/abcde/autorip.sh.gz | /bin/bash

