FROM ubuntu

WORKDIR /workdir

RUN apt-get update && apt-get -y install devscripts dh-make-perl

COPY buildscript.sh .

RUN ["/bin/sh","buildscript.sh" ]
