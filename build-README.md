#####################################################################
# use the following commands to build image and upload to dockerhub #
```
#####################################################################

xattr -c .git
xattr -c .gitignore
xattr -c .dockerignore
xattr -c *
chmod 0666 *
chmod 0777 *.sh
chmod 0777 scripts
chmod 0777 scripts/start.sh


docker build -f Dockerfile -t technoboggle/mysql-alpine:10.4.15-r0-3.12.3 .
docker run -it -p 3306:3306 -v $(pwd):/app --name mysql technoboggle/mysql-alpine:10.4.15-r0-3.12.3 -e MYSQL_DATABASE=admin -e MYSQL_USER=tony -e MYSQL_PASSWORD=dpa\*12d -e MYSQL_ROOT_PASSWORD=111111 technoboggle/mysql-alpine
docker run -it --rm -v $(pwd):/app -p 3306:3306 technoboggle/mysql-alpine:10.4.15-r0-3.12.3
docker tag technoboggle/mysql-alpine:10.4.15-r0-3.12.3 technoboggle/mysql-alpine:latest
docker login
docker push technoboggle/mysql-alpine:10.4.15-r0-3.12.3
docker push technoboggle/mysql-alpine:latest
docker container stop -t 10 mysql
#####################################################################
```
