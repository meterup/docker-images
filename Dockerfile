# Parts of this Dockerfile have been lifted from
# github.com/docker-library/golang. The source code for that project is released
# with an MIT license.

FROM ubuntu:18.04
RUN apt-get update && apt-get install -y --no-install-recommends \
        daemontools \
        g++ \
        gcc \
        libc6-dev \
        make \
        pkg-config \
        curl \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.12.8

RUN set -eux; \
    \
    # this "case" statement is generated via "update.sh"
    \
    dpkgArch="$(dpkg --print-architecture)"; \
    case "${dpkgArch##*-}" in \
    amd64) goRelArch='linux-amd64'; goRelSha256='bd26cd4962a362ed3c11835bca32c2e131c2ae050304f2c4df9fa6ded8db85d2' ;; \
    armhf) goRelArch='linux-armv6l'; goRelSha256='b6b057e7b5c740894132ce30e70503d7d36988dcd61a00f0865d1e7d6dcc74ca' ;; \
    arm64) goRelArch='linux-arm64'; goRelSha256='15e9e0b5b414d1a0322896368c0050af6ab1cd82d050e93f8eceb38ef2626652' ;; \
    i386) goRelArch='linux-386'; goRelSha256='be164c4e04205c4fc713e81594bc2fdd4c94dff3d567ec8e0072223dd0778287' ;; \
    ppc64el) goRelArch='linux-ppc64le'; goRelSha256='24a65f8a702ade1854f86ddf96eda554a8abd89c8a54ddc32788769419e90232' ;; \
    s390x) goRelArch='linux-s390x'; goRelSha256='db78fc8f9610cb27ac35aab55cb11698f4daa2101acdf46f0ba64e1db16323e5' ;; \
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
