# Parts of this Dockerfile have been lifted from
# github.com/docker-library/golang. The source code for that project is released
# with an MIT license.

# https://hub.docker.com/_/ubuntu
FROM ubuntu:bionic-20200219

ADD sources.list /etc/apt/sources.list
COPY bin /tmp/bin

ENV CONTAINER_BUILD_DATE 2020-02-25T17:00:00
ENV TZ UTC

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# Get the GOLANG_SHA256 checksum from https://golang.org/dl/, linux-amd64
RUN DEBIAN_FRONTEND=noninteractive \
    GOLANG_VERSION=1.14 \
    GOLANG_SHA256=08df79b46b0adf498ea9f320a0f23d6ec59e9003660b4c9c1ce8e5e2c6f823ca \
    GIT_VERSION=2.25.1 \
    /tmp/bin/install-dependencies && \
    mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

WORKDIR $GOPATH
