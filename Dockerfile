FROM uniqrn/ruby:v2.6
LABEL maintainer "unicorn research Ltd"

RUN apt-get update && apt-get install -y --no-install-recommends libjemalloc2 libsodium-dev \
    && rm -rf /var/lib/apt/lists/*
ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libjemalloc.so.2

COPY gemrc /root/.gemrc
COPY Gemfile /tmp/Gemfile
WORKDIR /tmp

RUN bundle install
ENV BUNDLE_GEMFILE /tmp/Gemfile
