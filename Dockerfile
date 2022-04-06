FROM alpine:latest
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
