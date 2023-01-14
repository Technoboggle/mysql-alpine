#!/usr/bin/env sh

owd="`pwd`"
cd "$(dirname "$0")"

mysql_ver="10.6.11-r0"
#mysql_ver="8.0.30"
alpine_ver="3.17.1"

# Setting File permissions
xattr -c .git
xattr -c .gitignore
xattr -c .dockerignore
xattr -c *
chmod 0666 *
chmod 0777 *.sh
chmod 0755 files
chmod 0755 files/*.sh

docker build -f Dockerfile -t technoboggle/mysql-alpine:"$mysql_ver-$alpine_ver" --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VCS_REF="`git rev-parse --verify HEAD`" --build-arg DB_VER="$mysql_ver"  --build-arg ALPINE_VER="$alpine_ver" --build-arg BUILD_VERSION=0.05 --no-cache .
#--progress=plain 

docker run -it -d -p 3306:3306 --name mymysql technoboggle/mysql-alpine:"$mysql_ver-$alpine_ver"
docker tag technoboggle/mysql-alpine:"$mysql_ver-$alpine_ver" technoboggle/mysql-alpine:latest
docker login
docker push technoboggle/mysql-alpine:"$mysql_ver-$alpine_ver"
docker push technoboggle/mysql-alpine:latest
docker container stop -t 10 mymysql

cd "$owd"
