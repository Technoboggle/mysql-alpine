ARG ALPINE_VERSION="${ALPINE_VERSION}"

FROM alpine:${ALPINE_VERSION}

ARG ALPINE_VERSION="${ALPINE_VERSION}"
ARG MYSQL_VERSION="${MYSQL_VERSION}"
ARG CURL_VERSION="${CURL_VERSION}"
ARG LIBXML2_VERSION="${LIBXML2_VERSION}"
ARG OPENKEYGEN_VERSION="${OPENKEYGEN_VERSION}"
ARG MAINTAINER_NAME="${MAINTAINER_NAME}"
ARG AUTHORNAME="${AUTHORNAME}"
ARG AUTHORS="${AUTHORS}"
ARG VERSION="${VERSION}"
ARG SCHEMAVERSION="${SCHEMAVERSION}"
ARG NAME="${NAME}"
ARG DESCRIPTION="${DESCRIPTION}"
ARG URL="${URL}"
ARG VCS_URL="${VCS_URL}"
ARG VCS_REF="${VCS_REF}"
ARG VENDOR="${VENDOR}"
ARG BUILD_VERSION="${BUILD_VERSION}"
ARG BUILD_LOCALLY="${BUILD_LOCALLY}"
ARG BUILD_DATE="${BUILD_DATE}"
ARG DOCKERCMD="${DOCKERCMD}"
ARG USAGE="${USAGE}"
ARG TIMEZONE="Europe/GMT"

# Labels.
LABEL \
    maintainer=${VCS_URL} \
    maintaintername=${MAINTAINER_NAME} \
    version=${VERSION} \
    description=${DESCRIPTION} \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name=${NAME} \
    org.label-schema.description=${DESCRIPTION} \
    org.label-schema.usage=${USAGE} \
    org.label-schema.url=${URL} \
    org.label-schema.vcs-url=${VCS_URL} \
    org.label-schema.vcs-ref=${VCS_REF} \
    org.label-schema.vendor=${VENDOR} \
    org.label-schema.version=${BUILD_VERSION} \
    org.label-schema.schema-version=${SCHEMAVERSION} \
    org.label-schema.docker.cmd=${DOCKERCMD} \
    org.label-schema.docker.cmd.devel="" \
    org.label-schema.docker.cmd.test="" \
    org.label-schema.docker.cmd.debug="" \
    org.label-schema.docker.cmd.help="" \
    org.label-schema.docker.params=""

# Installing packages MariaDB
RUN addgroup -S -g 1000 mysql && adduser -S -G mysql -u 999 mysql && \
    apk add --no-cache --upgrade --allow-untrusted --repository https://dl-cdn.alpinelinux.org/alpine/edge/main/  mysql=${MYSQL_VERSION} mysql-client=${MYSQL_VERSION} mariadb-server-utils=${MYSQL_VERSION} ca-certificates; \
	mkdir /scripts; \
    \
    apk add --no-cache --update \
    curl=${CURL_VERSION} \
    libxml2=${LIBXML2_VERSION} \
    openssh-keygen=${OPENKEYGEN_VERSION} \
    bash bash-completion gosu \
    --repository https://dl-cdn.alpinelinux.org/alpine/edge/main/ --allow-untrusted; \
    \
    rm -rf /var/cache/apk/* && \
    \
    mkdir /docker-entrypoint-initdb.d

COPY ./files/usage.txt /usr/doc/usage.txt

COPY ./files/healthcheck.sh /usr/local/bin/healthcheck.sh
COPY ./files/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mariadbd"]