ARG ALPINE_VERSION
ARG MYSQL_VERSION
ARG MAINTAINER_NAME
ARG AUTHORNAME
ARG AUTHORS
ARG VERSION
ARG SCHEMAVERSION
ARG NAME
ARG DESCRIPTION
ARG URL
ARG VCS_URL
ARG VENDOR
ARG BUILD_VERSION
ARG BUILD_DATE
ARG VCS_REF
ARG DOCKERCMD

FROM alpine:${ALPINE_VERSION}

ARG ALPINE_VERSION
ARG MYSQL_VERSION
ARG MAINTAINER_NAME
ARG AUTHORNAME
ARG AUTHORS
ARG VERSION
ARG SCHEMAVERSION
ARG NAME
ARG DESCRIPTION
ARG URL
ARG VCS_URL
ARG VENDOR
ARG BUILD_VERSION
ARG BUILD_DATE
ARG VCS_REF
ARG DOCKERCMD

#ENV TIMEZONE Europe/Paris
ENV TIMEZONE Europe/GMT
ENV MYSQL_DATABASE app
ENV MYSQL_USER app
ENV MYSQL_PASSWORD app
ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_CHARSET utf8
ENV MYSQL_COLLATION utf8_general_ci
ENV MYSQL_USER_MONITORING monitoring
ENV MYSQL_PASSWORD_MONITORING monitoring

# Labels.
LABEL maintainer=${MAINTAINER_NAME} \
    version=${VERSION} \
    description=${DESCRIPTION} \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name=${NAME} \
    org.label-schema.description=${DESCRIPTION} \
    org.label-schema.usage=${USAGE} \
    org.label-schema.url=${URL} \
    org.label-schema.vcs-url=${VCS_URL} \
    org.label-schema.vcs-ref=${VSC_REF} \
    org.label-schema.vendor=${VENDOR} \
    org.label-schema.version=${BUILDVERSION} \
    org.label-schema.schema-version=${SCHEMAVERSION} \
    org.label-schema.docker.cmd=${DOCKERCMD} \
    org.label-schema.docker.cmd.devel="" \
    org.label-schema.docker.cmd.test="" \
    org.label-schema.docker.cmd.debug="" \
    org.label-schema.docker.cmd.help="" \
    org.label-schema.docker.params=""

# Copy of the MySQL startup script
ADD files/run.sh /scripts/run.sh

# Installing packages MariaDB
RUN addgroup -S -g 1000 mysql && adduser -S -G mysql -u 999 mysql; \
    apk add --no-cache --upgrade \
		ca-certificates \
	    ; \
    \
    apk add --no-cache --upgrade \
    curl>=8.6.0-r0 \
    libxml2>="2.12.6-r0" \
    --repository https://dl-cdn.alpinelinux.org/alpine/edge/main/ \
    --allow-untrusted ; \
    \
    mkdir -a /app/mysql; \
    apk add --no-cache --update mysql=$MYSQL_VERSION mysql-client=$MYSQL_VERSION; \
    rm -f /var/cache/apk/* && \
    \
    mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

ENTRYPOINT ["/scripts/run.sh"]
