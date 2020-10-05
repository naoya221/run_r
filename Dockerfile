FROM ruby:2.6.5

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

RUN mkdir /workdir
WORKDIR /workdir

ADD ./Gemfile /workdir/Gemfile
ADD ./Gemfile.lock /workdir/Gemfile.lock

RUN gem install bundler
RUN bundle install
ADD . /workdir