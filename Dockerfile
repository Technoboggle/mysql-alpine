FROM alpine:3.15.5
MAINTAINER Edward Finlayson <edward.finlayson@btinternet.com>

LABEL APP="mariadb"
LABEL APP_REPOSITORY="https://pkgs.alpinelinux.org/package/edge/main/aarch64/mysql"

#ENV TIMEZONE Europe/Paris
ENV TIMEZONE Europe/GMT
ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABASE app
ENV MYSQL_USER app
ENV MYSQL_PASSWORD app
ENV MYSQL_USER_MONITORING monitoring
ENV MYSQL_PASSWORD_MONITORING monitoring

# Technoboggle Build time arguments.
ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

ENV ALPINE_VERSION 3.15.5

# Labels.
LABEL maintainer="edward.finlayson@btinternet.com"
LABEL net.technoboggle.authorname="Edward Finlayson" \
      net.technoboggle.authors="edward.finlayson@btinternet.com" \
      net.technoboggle.version="0.1" \
      net.technoboggle.description="This image builds a PHP-FPM server on Alpine" \
      net.technoboggle.buildDate="${BUILD_DATE}"

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date="${BUILD_DATE}"
LABEL org.label-schema.name="Technoboggle/php-fpm-alpine"
LABEL org.label-schema.description="Technoboggle lightweight php-fpm node"
LABEL org.label-schema.url="http://technoboggle.com/"
LABEL org.label-schema.vcs-url="https://github.com/Technoboggle/php-fpm"
LABEL org.label-schema.vcs-ref="$VCS_REF"
LABEL org.label-schema.vendor="WSO2"
LABEL org.label-schema.version="$BUILD_VERSION"
LABEL org.label-schema.docker.cmd="docker run -it -d -p 16379:6379 --rm --name myredis technoboggle/redis-alpine:${REDIS_VERSION}-${ALPINE_VERSION}"



# Installing packages MariaDB
RUN apk --no-cache --update add mysql mysql-client; \
    rm -f /var/cache/apk/*; \
    addgroup mysql mysql

# Work path
WORKDIR /scripts

# Copy of the MySQL startup script
COPY scripts/startup.sh startup.sh


# Creating the persistent volume
VOLUME [ "/var/lib/mysql" ]

COPY my.cnf /etc/mysql/my.cnf

#ENTRYPOINT [ "./start.sh" ]

EXPOSE 3306
CMD ["./startup.sh"]
