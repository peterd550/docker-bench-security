FROM alpine:3.12

ENV VERSION 3.12.0

MAINTAINER peter.dicker@gmail.com

WORKDIR /usr/bin

RUN apk update && \
    apk upgrade && \
    apk --update add curl && \
    curl -sS https://get.docker.com/builds/Linux/x86_64/docker-$VERSION > docker-$VERSION && \
    curl -sS https://get.docker.com/builds/Linux/x86_64/docker-$VERSION.sha256 > docker-$VERSION.sha256 && \
    sha256sum -c docker-$VERSION.sha256 && \
    ln -s docker-$VERSION docker && \
    chmod u+x docker-$VERSION && \
    apk del curl && \
    rm -rf /var/cache/apk/*

RUN mkdir /docker-bench-security

COPY . /docker-bench-security

WORKDIR /docker-bench-security

ENTRYPOINT ["/bin/sh", "docker-bench-security.sh"]
