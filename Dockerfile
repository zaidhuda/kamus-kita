FROM ruby:2.4.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /kamuskita
WORKDIR /kamuskita
ADD Gemfile /kamuskita/Gemfile
ADD Gemfile.lock /kamuskita/Gemfile.lock
RUN bundle install
ADD . /kamuskita