
# DOCU
    https://registry.hub.docker.com/_/mysql/

# SOURCE
    https://github.com/docker-library/mysql/tree/master/5.6

# BUILD
    docker build -t ducdebreme/mysql-5.6 .

# RUN
    docker run -e MYSQL_ROOT_PASSWORD=samba -P -d ducdebreme/mysql-5.6

