FROM ubuntu:bionic-20200219

ENV CONTAINER_BUILD_DATE 2020-03-04T17:00:00
ENV TZ UTC

COPY bin /tmp/bin
RUN DEBIAN_FRONTEND=noninteractive \
    GIT_VERSION=2.25.1 \
    RUBY_VERSION='2.7.0' \
    RUBY_PATH='/usr/local/ruby' \
    /tmp/bin/install-ruby
