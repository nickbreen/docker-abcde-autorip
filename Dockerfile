FROM ubuntu:xenial

RUN apt update && DEBIAN_FRONTEND=noninteractivr apt install --no-suggests -y abcde cdparanoia lame eyed3 imagemagick glyrc && apt clean 
ARG UID=1000
ARG GID
ARG LOGIN=autorip
RUN useradd -o -u ${UID} ${GID:+-g ${GID}} $LOGIN
USER ${LOGIN}
CMD gunzip /usr/share/doc/abcde/autorip.sh.gz | /bin/bash

