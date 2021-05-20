FROM ruby:2.5.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs --fix-missing --no-install-recommends
ENV BUNDLER_VERSION='2.1.4'
RUN gem install bundler --no-document -v '2.1.4'
RUN mkdir /bank-slip-validator
WORKDIR /bank-slip-validator
ADD Gemfile /bank-slip-validator/Gemfile
ADD Gemfile.lock /bank-slip-validator/Gemfile.lock
RUN bundle install
ADD . /bank-slip-validator
