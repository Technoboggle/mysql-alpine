# alpine-mysql
a docker image base on alpine with mysql

# build image
```
xattr -c .git
xattr -c .gitignore
xattr -c .dockerignore
xattr -c *
chmod 0666 *
chmod 0777 *.sh
chmod 0755 mysql
chmod 0755 scripts
chmod 0777 scripts/start.sh


docker build -f Dockerfile --progress=plain -t technoboggle/mysql-alpine:8.0.30-3.16.1 --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VCS_REF="`git rev-parse --verify HEAD`" --build-arg BUILD_VERSION=0.05 --no-cache --progress=plain .

in the above pay special attenttion to the values to be updated which are:
  8.0.30-3.16.1                 = MySQL version - alpine version
  "`git rev-parse --verify HEAD`"  = git commit SHA key
  0.05                             = current version of this image



docker run -it -d -v $(pwd):/app -p 3306:3306 --rm --name mymysql --env-file .env technoboggle/mysql-alpine:8.0.30-3.16.1
#docker run -it --rm -v $(pwd):/app -p 3306:3306 technoboggle/mysql-alpine:8.0.30-3.16.1
docker tag technoboggle/mysql-alpine:8.0.30-3.16.1 technoboggle/mysql-alpine:8.0.30-3.16.1
docker tag technoboggle/mysql-alpine:8.0.30-3.16.1 technoboggle/mysql-alpine:latest
docker login
docker push technoboggle/mysql-alpine:8.0.30-3.16.1
docker push technoboggle/mysql-alpine:latest
docker container stop -t 10 mymysql

```

# Usage
```
docker run -it --name mymysql -p 3306:3306 -v $(pwd):/app -e MYSQL_DATABASE=admin -e MYSQL_USER=tony -e MYSQL_PASSWORD=dpa\*12d -e MYSQL_ROOT_PASSWORD=111111 technoboggle/mysql-alpine
```

It will create a new db, and set mysql root password(default is 111111)


docker run -it -d -p 3306:3306 -v $(pwd):/app --env MYSQL_DATABASE=admin --env MYSQL_USER=tony --env MYSQL_PASSWORD=dpa\*12d --env MYSQL_ROOT_PASSWORD=111111 --name mysql10 technoboggle/mysql-alpine:10.5.12-r0-3.14.2


Jan 19 10:11:10 kernel: 00:E0:4C:6E:00:E9 not mesh client, can't delete it
Jan 19 10:11:10 kernel: D8:F1:5B:DB:55:2A not mesh client, can't delete it
Jan 19 10:11:17 syslog: wlceventd_proc_event(491): eth1: Deauth_ind DC:85:DE:3E:27:BF, status: 0, reason: Disassociated due to inactivity (4), rssi:0
Jan 19 10:11:26 pppd[928]: Timeout waiting for PADO packets


deprecated the use of the :latest tag as it seeds confusion
