FROM ruby:2.3
MAINTAINER unicorn research Ltd

ADD Gemfile /tmp/Gemfile
WORKDIR /tmp

RUN bundle update
