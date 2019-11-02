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

ENV GOLANG_VERSION 1.13.4

RUN set -eux; \
    \
    dpkgArch="$(dpkg --print-architecture)"; \
    case "${dpkgArch##*-}" in \
    # Get the checksum from https://golang.org/dl/, linux-amd64
        amd64) goRelArch='linux-amd64'; goRelSha256='692d17071736f74be04a72a06dab9cac1cd759377bd85316e52b2227604c004c' ;; \
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
