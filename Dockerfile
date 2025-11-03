FROM ruby:3.2.2-slim-bookworm@sha256:b1b1636eb4e9d3499fc6166f54f7bb96d792e005b887091346fd1ae01ad97229 AS base

# Install libpq-dev in our base layer, as it's needed in all environments
RUN apt-get update \
  && apt-get install -y libpq-dev \
  && rm -rf /var/lib/apt/lists/*

ENV RUBY_BUNDLER_VERSION 2.4.22
RUN gem install bundler -v $RUBY_BUNDLER_VERSION

ENV BUNDLE_PATH /usr/local/bundle

ENV RUBYOPT=-W:deprecated

FROM base AS dev-environment

# Install build-essential and git, as we'd need them for building gems that have native code components
RUN apt-get update \
  && apt-get install -y build-essential git \
  && rm -rf /var/lib/apt/lists/*
