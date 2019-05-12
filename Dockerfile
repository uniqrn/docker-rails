FROM ruby:latest
LABEL maintainer "unicorn research Ltd"

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN apt-get update && apt-get install -y --no-install-recommends libjemalloc1 \
    && rm -rf /var/lib/apt/lists/*
ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libjemalloc.so.1

COPY gemrc /root/.gemrc
COPY Gemfile /tmp/Gemfile
WORKDIR /tmp

RUN gem update --system
RUN bundle install
ENV BUNDLE_GEMFILE /tmp/Gemfile
