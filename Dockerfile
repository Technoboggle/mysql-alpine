FROM alpine:3.12.3
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





WORKDIR /app
VOLUME /app
COPY startup.sh /startup.sh

RUN apk --update add mysql mysql-client && rm -f /var/cache/apk/*
RUN addgroup mysql mysql

# Work path
WORKDIR /scripts

# Copy of the MySQL startup script
#COPY scripts/start.sh start.sh

# Creating the persistent volume
VOLUME [ "/var/lib/mysql" ]

#ENTRYPOINT [ "./start.sh" ]

COPY my.cnf /etc/mysql/my.cnf

EXPOSE 3306
CMD ["/startup.sh"]
