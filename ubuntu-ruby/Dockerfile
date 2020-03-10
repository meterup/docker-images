FROM ubuntu:bionic-20200219 AS gitbuild
ENV CONTAINER_BUILD_DATE=2020-03-09T11:00:00 \
    TZ=UTC \
    DEBIAN_FRONTEND=noninteractive
COPY bin/git /tmp/gitbin
RUN /tmp/gitbin/install-deps
ENV GIT_VERSION=2.25.1
RUN /tmp/gitbin/compile "${GIT_VERSION}"

FROM ubuntu:bionic-20200219 AS nodebuild
ENV CONTAINER_BUILD_DATE=2020-03-09T11:00:00 \
    TZ=UTC \
    DEBIAN_FRONTEND=noninteractive \
    PATH="${PATH}:/usr/local/git/bin"

COPY bin/node /tmp/nodebin
COPY --from=gitbuild /usr/local/git /usr/local/git

RUN /tmp/nodebin/install-deps
ENV NODE_VERSION=12.16.1 \
    NODE_SHA256='b2d9787da97d6c0d5cbf24c69fdbbf376b19089f921432c5a61aa323bc070bea' \
    NPM_VERSION=6.14.2 \
    YARN_VERSION=1.22.4
RUN /tmp/nodebin/compile "${NODE_VERSION}" "${NPM_VERSION}" "${YARN_VERSION}"

FROM ubuntu:bionic-20200219 AS rubybuild
ENV CONTAINER_BUILD_DATE=2020-03-09T11:00:00 \
    TZ=UTC \
    DEBIAN_FRONTEND=noninteractive \
    PATH="${PATH}:/usr/local/git/bin:/usr/local/node/bin:/usr/local/yarn/bin:/usr/local/ruby/bin"

COPY bin/ruby /tmp/rubybin
COPY bin/common /tmp/commonbin
COPY --from=gitbuild /usr/local/git /usr/local/git
COPY --from=nodebuild /usr/local/node /usr/local/node
COPY --from=nodebuild /usr/local/yarn /usr/local/yarn
RUN /tmp/rubybin/init-machine

# Some adaptations from https://github.com/drecom/docker-ubuntu-ruby/blob/master/Dockerfile
# checksum from https://nodejs.org/dist/v12.16.1/SHASUMS256.txt.asc
RUN /tmp/rubybin/install-deps
# ruby-build needs PREFIX to be set (see install.sh script)
RUN export \
    RUBY_VERSION='2.7.0' \
    RUBY_PATH='/usr/local/ruby' \
    PREFIX='/usr/local/ruby' && \

    mkdir -p "${RUBY_PATH}" && \
    chown -R meter:meter "${RUBY_PATH}" && \
    sudo --preserve-env=PATH,RUBY_VERSION,RUBY_PATH,PREFIX -H -u meter \
        bash -c '/tmp/rubybin/compile "${RUBY_VERSION}" "${RUBY_PATH}"' && \
    /tmp/commonbin/cleanup && \

    unset RUBY_VERSION && \
    unset PREFIX
