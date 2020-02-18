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
    GOLANG_VERSION=1.14rc1 \
    GOLANG_SHA256=69398d41e5f6b87cdf3969aae665be4dfd3cc2ef36a61ab47a261f96130ed788 \
    GIT_VERSION=2.25.1 \
    /tmp/bin/install-dependencies && \
    mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

WORKDIR $GOPATH
