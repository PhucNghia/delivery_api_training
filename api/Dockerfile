FROM ruby:2.6
RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir -p /delivery/api
WORKDIR /delivery/api
COPY Gemfile /delivery/api/Gemfile
COPY Gemfile.lock /delivery/api/Gemfile.lock
RUN gem install bundle
RUN bundle install
VOLUME /user/local/bundle
COPY . /delivery/api
