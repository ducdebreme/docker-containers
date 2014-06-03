docker-lamp
===========

Provides a docker base LAMP container.

sudo docker build -t  ducdebreme/lamp53 .


sudo docker run --name Drupal7 -t -i -v $(pwd):/var/www -v $(pwd)/logs:/var/log -p 3306:3306 -p 80:80  ducdebreme/lamp53 bash

sudo docker run --name Drupal6 -t -i -v $(pwd):/var/www -v $(pwd)/logs:/var/log -p 3306:3306 -p 80:80  ducdebreme/lamp53 bash

# to allow ssh
sudo docker run --name "$INSTANCE-Lamp" --link "$INSTANCE-Solr":solr -t -i -v $(pwd):/var/www -v $(pwd)/_docker/logs:/var/log -v $(pwd)/.ssh:/root/.ssh -p 3306:3306 -p 80:80 -p 2222:22 -e "BACKUP_SOURCE=$BACKUP_SOURCE" ducdebreme/lamp53 bash

# ====== next steps in container
bash /root/start.sh &


# in the container / NOT in image!!
mv /var/www/.ssh/ /root
chown -R root /root/.ssh

mysql < /var/www/_vagrant/mysql/create-admin-user.sql 

# login
eval `ssh-agent -s`
ssh-add

cd /var/www/
chown -R www-data sites/early-dance.de/files
sh _vagrant/shell/get-early-dance.sh



# ====== start for dev
sudo docker ps -a
CONTAINER ID        IMAGE                      COMMAND             CREATED             STATUS                       PORTS               NAMES
70bb4e13542c        ducdebreme/lamp53:latest   bash                18 minutes ago      Exited (255) 6 minutes ago                       Drupal6
sudo docker start Drupal6
sudo docker attach Drupal6
bash /root/start.sh &

