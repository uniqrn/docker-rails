FROM ruby:latest
LABEL maintainer "unicorn research Ltd"

ENV DOCKERIZE_VERSION v0.3.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN apt-get update && apt-get install -y --no-install-recommends libjemalloc1 \
    && rm -rf /var/lib/apt/lists/*

COPY gemrc /root/.gemrc
COPY Gemfile /tmp/Gemfile
WORKDIR /tmp

RUN gem update --system
RUN bundle install --without test development
ENV BUNDLE_GEMFILE /opt/Gemfile
