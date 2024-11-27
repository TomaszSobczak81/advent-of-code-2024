FROM ruby:3.3.6-alpine3.20

ARG UID
ARG GID

RUN apk add --update --no-cache bash git musl-dev

WORKDIR /mnt/app

RUN addgroup -g ${GID} code && adduser -D -G code -u ${UID} code

USER code

CMD while [ true ]; do sleep 3; done
