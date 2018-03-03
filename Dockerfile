ARG image
FROM ${image}

WORKDIR /workdir

RUN apt-get update && apt-get -y install dh-make-perl

#ENV DEBFULLNAME=Alex
#ENV DEBEMAIL=AlexDeb@bla.com
#ENV EMAIL=Alex@bla.com

VOLUME .

COPY buildscript.sh .
RUN ["/bin/sh","buildscript.sh" ]
