# Parts of this Dockerfile have been lifted from
# github.com/docker-library/golang. The source code for that project is released
# with an MIT license.

# https://hub.docker.com/_/ubuntu
FROM ubuntu:bionic-20191029

ADD sources.list /etc/apt/sources.list
COPY bin /tmp/bin

ENV DEBIAN_FRONTEND noninteractive
ENV CONTAINER_BUILD_DATE 2019-12-03T14:00:00

# git: we need for github.com/kevinburke/differ
# openssh-client: apmanage generates SSH keys
# time: reporting command execution time
# daemontools: envdir
# gettext,lib*-dev, zlib1g-dev: git
RUN apt-get update && apt-get install -y apt-transport-https && \
    apt-get install -y --no-install-recommends \
        autoconf \
        ca-certificates \
        curl \
        daemontools \
        g++ \
        gcc \
        gettext \
        gnupg \
        less \
        libc6-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        make \
        openssh-client \
        pkg-config \
        sudo \
        time \
        unzip \
        zlib1g-dev \
        && \
    /tmp/bin/compile-git && \
    curl --silent https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" >> /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends postgresql-11 postgresql-client-11 && \
    /tmp/bin/compile-go && \
    apt-get remove -y --purge autoconf gettext libssl-dev libcurl4-openssl-dev zlib1g-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH
