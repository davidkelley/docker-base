FROM alpine:3.4

ARG mount_path=/app

ENV DEBIAN_FRONTEND=noninteractive MOUNT_PATH=$mount_path \
    BUILD_PACKAGES="build-base ca-certificates libxml2 libxslt openssl yaml git zlib glib" \
    RUBY_PACKAGES="ruby ruby-io-console ruby-dev ruby-bundler"

COPY harden.sh /usr/sbin/harden.sh

RUN apk update && apk upgrade && apk add ${BUILD_PACKAGES} ${RUBY_PACKAGES} && rm -rf /var/cache/apk/* \
    && echo 'gem: --no-document' >> ~/.gemrc && echo 'gem: --no-document' >> /etc/gemrc \
    && /usr/sbin/harden.sh

USER user

# Setup the working directory
WORKDIR $MOUNT_PATH

# Default the command to start the server
CMD ["puma"]
