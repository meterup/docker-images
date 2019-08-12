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

ENV GOLANG_VERSION 1.12.7

RUN set -eux; \
    \
    # this "case" statement is generated via "update.sh"
    \
    dpkgArch="$(dpkg --print-architecture)"; \
    case "${dpkgArch##*-}" in \
    amd64) goRelArch='linux-amd64'; goRelSha256='66d83bfb5a9ede000e33c6579a91a29e6b101829ad41fffb5c5bb6c900e109d9' ;; \
    armhf) goRelArch='linux-armv6l'; goRelSha256='48edbe936e9eb74f259bfc4b621fafca4d4ec43156b4ee7bd0d979f257dcd60a' ;; \
    arm64) goRelArch='linux-arm64'; goRelSha256='4da1f7198a8fa0c4067852656b6c10153a4eca5a26aca28ef02ae9f4a7939ba5' ;; \
    i386) goRelArch='linux-386'; goRelSha256='ae2424b7ff557a708be12d3141f25b645966489ca49af1ad10b4fbe4c97d4c41' ;; \
    ppc64el) goRelArch='linux-ppc64le'; goRelSha256='8eda20600d90247efbfa70d116d80056e11192d62592240975b2a8c53caa5bf3' ;; \
    s390x) goRelArch='linux-s390x'; goRelSha256='3374ac3d646555e50be790091b51849319cfcb176904048458c7f4252337fce8' ;; \
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
