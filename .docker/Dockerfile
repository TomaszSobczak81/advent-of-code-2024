FROM ruby:3.3.6-alpine3.20

# Set the build arguments
ARG DOCKER_USER=app
ARG DOCKER_USER_ID=1000
ARG DOCKER_GROUP=app
ARG DOCKER_GROUP_ID=1000

# Install the required packages
RUN apk add --update --no-cache bash git musl-dev

# Create a user and group to run our app using the same id as the host user
# This is to avoid permission issues between the host and the container
RUN addgroup -g ${DOCKER_GROUP_ID} ${DOCKER_GROUP} \
    && adduser -D -u ${DOCKER_USER_ID} -G ${DOCKER_GROUP} ${DOCKER_USER}

# Copy the Gemfile and install the gems
COPY ../Gemfile /Gemfile
COPY ../Gemfile.lock /Gemfile.lock
RUN gem install bundler:2.3.6
RUN bundle install

# Copy the source code
COPY ../src /mnt/app/src
COPY ../var /mnt/app/var

# Tell docker that all future commands should run as the app user
USER ${DOCKER_USER}

# Set the working directory
WORKDIR /mnt/app
