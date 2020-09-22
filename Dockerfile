FROM ruby:2.6.5

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

RUN mkdir /run_r

ENV APP_ROOT /run_r
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN gem install bundler
RUN bundle install
ADD . $APP_ROOT