FROM ubuntu:bionic-20200219 AS gitbuild
ENV CONTAINER_BUILD_DATE=2020-03-09T11:00:00 \
    TZ=UTC \
    DEBIAN_FRONTEND=noninteractive
COPY bin /tmp/bin
RUN /tmp/bin/install-git-dependencies
ENV GIT_VERSION=2.25.1
RUN /tmp/bin/compile-git "${GIT_VERSION}"

FROM ubuntu:bionic-20200219 AS nodebuild
ENV CONTAINER_BUILD_DATE=2020-03-09T11:00:00 \
    TZ=UTC \
    DEBIAN_FRONTEND=noninteractive \
    PATH="${PATH}:/usr/local/git/bin"

COPY bin /tmp/bin
COPY --from=gitbuild /usr/local/git /usr/local/git

RUN /tmp/bin/install-node-dependencies
ENV NODE_VERSION=12.16.1 \
    NODE_SHA256='b2d9787da97d6c0d5cbf24c69fdbbf376b19089f921432c5a61aa323bc070bea' \
    NPM_VERSION=6.14.2
RUN /tmp/bin/compile-node "${NODE_VERSION}" "${NPM_VERSION}"

FROM ubuntu:bionic-20200219 AS rubybuild
ENV CONTAINER_BUILD_DATE=2020-03-09T11:00:00 \
    TZ=UTC \
    DEBIAN_FRONTEND=noninteractive \
    PATH="${PATH}:/usr/local/git/bin:/usr/local/node/bin:/usr/local/ruby/bin"

COPY bin /tmp/bin
COPY --from=gitbuild /usr/local/git /usr/local/git
COPY --from=nodebuild /usr/local/node /usr/local/node

# Some adaptations from https://github.com/drecom/docker-ubuntu-ruby/blob/master/Dockerfile
# checksum from https://nodejs.org/dist/v12.16.1/SHASUMS256.txt.asc
RUN /tmp/bin/install-dependencies
ENV RUBY_VERSION='2.7.0' \
    RUBY_PATH='/usr/local/ruby'
RUN /tmp/bin/install-ruby "${RUBY_VERSION}" "${RUBY_PATH}"
