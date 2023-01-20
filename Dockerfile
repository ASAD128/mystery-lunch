# syntax=docker/dockerfile:1
FROM ruby:2.7
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client imagemagick
RUN apt-get install -y cron
WORKDIR /mystery-lunch-app

COPY . .

RUN bundle install


EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]