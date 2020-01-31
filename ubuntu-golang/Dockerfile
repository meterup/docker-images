# Parts of this Dockerfile have been lifted from
# github.com/docker-library/golang. The source code for that project is released
# with an MIT license.

# https://hub.docker.com/_/ubuntu
FROM ubuntu:bionic-20200112

ADD sources.list /etc/apt/sources.list
COPY bin /tmp/bin

ENV CONTAINER_BUILD_DATE 2020-01-31T13:00:00
ENV TZ UTC

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# Get the GOLANG_SHA256 checksum from https://golang.org/dl/, linux-amd64
RUN DEBIAN_FRONTEND=noninteractive \
    GOLANG_VERSION=1.14beta1 \
    GOLANG_SHA256=ebe68aa4219b673dbd060b8a6d9a339b6b6b0383772aa4349c8183f0a8f339e4 \
    GIT_VERSION=2.25.0 \
    /tmp/bin/install-dependencies && \
    mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

WORKDIR $GOPATH
