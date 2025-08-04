FROM ruby:bookworm

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN apt-get update -qq && apt-get upgrade -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
     ffmpeg imagemagick

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN chmod a+x ./nebibot.rb
ENTRYPOINT ["ruby", "./nebibot.rb"]

