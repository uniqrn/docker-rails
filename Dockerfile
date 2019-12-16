FROM ruby:2.6.5-buster AS builder
COPY Gemfile /tmp/Gemfile
WORKDIR /tmp
RUN bundle install

FROM uniqrn/ruby:v2.6 AS production
LABEL maintainer "unicorn research Ltd"

# setup rails dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libjemalloc2 libsqlite3-0 libpq5 libsodium-dev \
    openssh-server curl \
    git \
    && rm -rf /var/lib/apt/lists/*
ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libjemalloc.so.2

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /root/.bundle /root/.bundle
COPY --from=builder /tmp/Gemfile.lock /tmp/Gemfile.lock
COPY Gemfile /tmp/Gemfile

# setup ssh access
RUN mkdir /var/run/sshd
COPY res/sshd_config /etc/ssh/sshd_config
COPY res/ssh-environment /root/.ssh/environment
RUN chmod 700 /root/.ssh/

ENV BUNDLE_GEMFILE /tmp/Gemfile
WORKDIR /tmp
