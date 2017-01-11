FROM alpine:3.4

ARG mount_path=/app

ENV DEBIAN_FRONTEND=noninteractive MOUNT_PATH=$mount_path \
    DB_PACKAGES="mysql-dev mysql-client" \
    BUILD_PACKAGES="build-base linux-grsec ca-certificates libxml2 libxslt openssl yaml git zlib glib libffi libffi-dev" \
    RUBY_PACKAGES="ruby ruby-io-console ruby-dev ruby-rake ruby-bundler"

RUN apk update && apk upgrade && apk add ${BUILD_PACKAGES} ${DB_PACKAGES} ${RUBY_PACKAGES} && rm -rf /var/cache/apk/* \
    && echo 'gem: --no-document' >> ~/.gemrc && echo 'gem: --no-document' >> /etc/gemrc

# Setup the working directory
WORKDIR $MOUNT_PATH

COPY harden.sh /usr/sbin/harden.sh

RUN /usr/sbin/harden.sh

USER user

# Default the command to start the server
CMD ["puma"]
