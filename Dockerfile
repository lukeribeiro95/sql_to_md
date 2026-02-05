FROM ruby:3.2-alpine

RUN apk add --no-cache git build-base yaml-dev

WORKDIR /app

COPY . .

RUN bundle install

CMD ["bundle", "exec", "rspec"]