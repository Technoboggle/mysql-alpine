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
chmod 0777 scripts
chmod 0777 scripts/start.sh


docker build -f Dockerfile -t technoboggle/mysql-alpine:10.5.8-3.13.2 .
docker run -it -d -p 3306:3306 -v $(pwd):/app --name mysql technoboggle/mysql-alpine:10.5.8-3.13.2 -e MYSQL_DATABASE=admin -e MYSQL_USER=tony -e MYSQL_PASSWORD=dpa\*12d -e MYSQL_ROOT_PASSWORD=111111 technoboggle/mysql-alpine
docker run -it --rm -v $(pwd):/app -p 3306:3306 technoboggle/mysql-alpine:10.5.8-3.13.2
docker tag technoboggle/mysql-alpine:10.5.8-3.13.2 technoboggle/mysql-alpine:latest
docker login
docker push technoboggle/mysql-alpine:10.5.8-3.13.2
docker push technoboggle/mysql-alpine:latest
docker container stop -t 10 mysql

```

# Usage
```
docker run -it --name mysql -p 3306:3306 -v $(pwd):/app -e MYSQL_DATABASE=admin -e MYSQL_USER=tony -e MYSQL_PASSWORD=dpa\*12d -e MYSQL_ROOT_PASSWORD=111111 wangxian/alpine-mysql
```

It will create a new db, and set mysql root password(default is 111111)


