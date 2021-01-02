# alpine-mysql
a docker image base on alpine with mysql

# build image
```
docker build -f build-mysql.Dockerfile -t technoboggle/mysql:10.4.15-r0-alpine .
docker run -it --rm -v $(pwd):/app -p 3306:3306 technoboggle/mysql:10.4.15-r0-alpine
```

# Usage
```
docker run -it --name mysql -p 3306:3306 -v $(pwd):/app -e MYSQL_DATABASE=admin -e MYSQL_USER=tony -e MYSQL_PASSWORD=dpa\*12d -e MYSQL_ROOT_PASSWORD=111111 wangxian/alpine-mysql
```

It will create a new db, and set mysql root password(default is 111111)

#####################################################################
# use the following commands to build image and upload to dockerhub
```
chmod 0755 scripts/start.sh
docker build -f build-mysql.Dockerfile -t technoboggle/mysql:10.4.15-r0-alpine .

docker run -it -p 3306:3306 -v $(pwd):/app --name mysql technoboggle/mysql:10.4.15-r0-alpine -e MYSQL_DATABASE=admin -e MYSQL_USER=tony -e MYSQL_PASSWORD=dpa\*12d -e MYSQL_ROOT_PASSWORD=111111 technoboggle/mysql-alpine
docker run -it --rm -v $(pwd):/app -p 3306:3306 technoboggle/mysql:10.4.15-r0-alpine
#docker tag php-fpm:8.0.0-alpine technoboggle/php-fpm:8.0.0-alpine
docker login
docker push technoboggle/php-fpm:8.0.0-alpine
docker container stop -t 10 mysql
```



# Build Instructions


