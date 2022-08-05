#!/usr/bin/env sh

owd="`pwd`"
cd "$(dirname "$0")"

mysql_ver="10.6.8-r0"
alpine_ver="3.16.1"

# Setting File permissions
xattr -c .git
xattr -c .gitignore
xattr -c .dockerignore
xattr -c *
chmod 0666 *
chmod 0777 *.sh
chmod 0755 mysql
chmod 0755 scripts
chmod 0777 scripts/*.sh

docker build -f Dockerfile -t technoboggle/mysql-alpine:"$mysql_ver-$alpine_ver" --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VCS_REF="`git rev-parse --verify HEAD`" --build-arg BUILD_VERSION=0.05 --no-cache .
#--progress=plain 

docker run -it -d --rm -p 3306:3306 --name mymysql technoboggle/mysql-alpine:"$mysql_ver-$alpine_ver"
#docker tag technoboggle/mysql-alpine:"$mysql_ver-$alpine_ver" technoboggle/mysql-alpine:latest
docker login
docker push technoboggle/mysql-alpine:"$mysql_ver-$alpine_ver"
#docker push technoboggle/mysql-alpine:latest
docker container stop -t 10 mymysql

cd "$owd"
