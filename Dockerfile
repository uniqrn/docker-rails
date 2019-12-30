FROM ruby:2.6.5-buster AS builder
COPY Gemfile /tmp/Gemfile
WORKDIR /tmp
RUN bundle install

FROM uniqrn/ruby:v2.6 AS production
LABEL maintainer "unicorn research Ltd"

RUN apt-get update && apt-get install -y --no-install-recommends \
    libjemalloc2 libsqlite3-0 libpq5 libsodium-dev \
    && rm -rf /var/lib/apt/lists/*
ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libjemalloc.so.2

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /root/.bundle /root/.bundle
COPY --from=builder /tmp/Gemfile.lock /tmp/Gemfile.lock
COPY Gemfile /tmp/Gemfile
WORKDIR /tmp

ENV BUNDLE_GEMFILE /tmp/Gemfile
