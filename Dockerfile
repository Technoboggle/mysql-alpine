FROM alpine:3.17.1
MAINTAINER Edward Finlayson <edward.finlayson@btinternet.com>

LABEL APP="MySQL"
LABEL APP_REPOSITORY="https://pkgs.alpinelinux.org/package/edge/main/aarch64/mysql"

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

# Technoboggle Build time arguments.
ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

ARG DB_VER=10.6.11-r0
#ENV MYSQL_VERSION 8.0.30
ARG ALPINE_VER=3.17.1


#ENV MYSQL_VERSION "$DB_VER"
#ENV MYSQL_VERSION 8.0.30
#ENV ALPINE_VERSION "$ALPINE_VER"

# Labels.
LABEL maintainer="Edward Finlayson <edward.finlayson@btinternet.com>" \
    architecture="amd64/x86_64" \
    mariadb-version="${DB_VER}" \
    alpine-version="${ALPINE_VER}" \
    build="${BUILD_DATE}" \
    net.technoboggle.authorname="Edward Finlayson" \
    net.technoboggle.authors="edward.finlayson@btinternet.com" \
    net.technoboggle.version="0.1" \
    net.technoboggle.description="This image builds a PHP-FPM server on Alpine" \
    net.technoboggle.buildDate="${BUILD_DATE}" \
    org.opencontainers.image.title="alpine-mariadb" \
    org.opencontainers.image.description="MariaDB Docker image running on Alpine Linux" \
    org.opencontainers.image.authors="Edward Finlayson <edward.finlayson@btinternet.com>" \
    org.opencontainers.image.vendor="Teechnoboggle" \
    org.opencontainers.image.version="v10.6.11-r0" \
    org.opencontainers.image.url="https://hub.docker.com/r/technoboggle/mysql-alpine" \
    org.opencontainers.image.source="https://github.com/Technoboggle/mysql-alpine" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE

# Installing packages MariaDB
RUN addgroup -S -g 1000 mysql && adduser -S -G mysql -u 999 mysql; \
    mkdir -a /app/mysql; \
    apk add --no-cache --update mysql=$DB_VER mysql-client=$DB_VER; \
    rm -f /var/cache/apk/*

# Copy of the MySQL startup script
ADD files/run.sh /scripts/run.sh

RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]
