ARG image
FROM ${image}

WORKDIR /workdir

RUN apt-get update && apt-get -y install dh-make-perl

COPY buildscript.sh .

RUN ["/bin/sh","buildscript.sh" ]
