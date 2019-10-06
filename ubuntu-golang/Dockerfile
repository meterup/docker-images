# Parts of this Dockerfile have been lifted from
# github.com/docker-library/golang. The source code for that project is released
# with an MIT license.

FROM ubuntu:18.04

ADD sources.list /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive

# git: we need for github.com/kevinburke/differ
# openssh-client: apmanage generates SSH keys
# time: reporting command execution time
# daemontools: envdir
RUN apt-get update && apt-get install -y apt-transport-https && \
    apt-get install -y --no-install-recommends \
        daemontools \
        gnupg \
        time \
        sudo \
        g++ \
        gcc \
        git \
        less \
        openssh-client \
        libc6-dev \
        make \
        pkg-config \
        curl \
        ca-certificates && \
        curl --silent https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
        echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" >> /etc/apt/sources.list.d/pgdg.list && \
        apt-get update && \
        apt-get install -y --no-install-recommends postgresql postgresql-client && \
        rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.13.1

RUN set -eux; \
    \
    dpkgArch="$(dpkg --print-architecture)"; \
    case "${dpkgArch##*-}" in \
    # Get these from github.com/docker-library/golang/1.13/buster/Dockerfile
        amd64) goRelArch='linux-amd64'; goRelSha256='94f874037b82ea5353f4061e543681a0e79657f787437974214629af8407d124' ;; \
        armhf) goRelArch='linux-armv6l'; goRelSha256='7c75d4002321ea4a066dfe13f6dd5168076e9a231317c5afd55e78b86f478e37' ;; \
        arm64) goRelArch='linux-arm64'; goRelSha256='8af8787b7c2a3c0eb3f20f872577fcb6c36098bf725c59c4923921443084c807' ;; \
        i386) goRelArch='linux-386'; goRelSha256='4bf7a961fda7ad892b8824002036de8c0f290df05df2e8f11252d1f8c77dcd8f' ;; \
        ppc64el) goRelArch='linux-ppc64le'; goRelSha256='72422c68dbed013ee321a05dbb97d9c8d6b2c75f347de707138c2c748fc4aceb' ;; \
        s390x) goRelArch='linux-s390x'; goRelSha256='5f0859ae1037ad7af6cdb6d16f638de908fd9de044d463eeab92b9578d4c7c75' ;; \
    esac; \
    \
    url="https://golang.org/dl/go${GOLANG_VERSION}.${goRelArch}.tar.gz"; \
    curl --location --output go.tgz "$url"; \
    echo "${goRelSha256} *go.tgz" | sha256sum -c -; \
    tar -C /usr/local -xzf go.tgz; \
    rm go.tgz; \
    \
    export PATH="/usr/local/go/bin:$PATH"; \
    go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH
