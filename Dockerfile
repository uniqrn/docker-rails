FROM ruby:latest
MAINTAINER unicorn research Ltd

ADD Gemfile /tmp/Gemfile
WORKDIR /tmp

RUN bundle update
