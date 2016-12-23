FROM alpine:3.4

ENV DEBIAN_FRONTEND noninteractive \
    BUILD_PACKAGES="build-base ca-certificates libxml2 libxslt openssl yaml git zlib glib" \
    RUBY_PACKAGES="ruby ruby-io-console ruby-dev ruby-bundler"

# Configure deps.
RUN apk update && apk upgrade && apk add ${BUILD_PACKAGES} ${RUBY_PACKAGES} && rm -rf /var/cache/apk/* \
    && echo 'gem: --no-document' >> ~/.gemrc && echo 'gem: --no-document' >> /etc/gemrc

# Setup the working directory
WORKDIR /app

# Default the command to start the server
CMD ["puma"]
