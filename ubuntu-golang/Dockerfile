FROM ubuntu:bionic-20200219 AS gitbuild
ENV CONTAINER_BUILD_DATE=2020-03-09T11:00:00 \
    TZ=UTC \
    DEBIAN_FRONTEND=noninteractive
COPY bin/git /tmp/gitbin
RUN /tmp/gitbin/install-deps
ENV GIT_VERSION=2.25.1
RUN /tmp/gitbin/compile "${GIT_VERSION}"

# Parts of this Dockerfile have been lifted from
# github.com/docker-library/golang. The source code for that project is released
# with an MIT license.

# https://hub.docker.com/_/ubuntu
FROM ubuntu:bionic-20200219

ADD sources.list /etc/apt/sources.list

ENV CONTAINER_BUILD_DATE=2020-02-25T17:00:00 \
    TZ=UTC \
    DEBIAN_FRONTEND=noninteractive \
    GOPATH=/go \
    PATH="${GOPATH}/bin:/usr/local/go/bin:${PATH}:/usr/local/git/bin"

COPY bin/go /tmp/gobin
COPY --from=gitbuild /usr/local/git /usr/local/git
RUN /tmp/gobin/install-deps

# Get the GOLANG_SHA256 checksum from https://golang.org/dl/, linux-amd64
RUN export \
    GOLANG_VERSION=1.14 \
    GOLANG_SHA256=08df79b46b0adf498ea9f320a0f23d6ec59e9003660b4c9c1ce8e5e2c6f823ca && \

    /tmp/gobin/compile "${GOLANG_VERSION}" "${GOLANG_SHA256}" && \
    mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH" && \

    unset GOLANG_VERSION && \
    unset GOLANG_SHA256

WORKDIR $GOPATH
