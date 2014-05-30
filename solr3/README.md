docker-lamp
===========

Provides a docker base LAMP container.

sudo docker build -t ducdebreme/solr3 .


sudo docker run --name Solr3 -t -i -v $(pwd):/var/solr/example/solr -p 8983:8983 ducdebreme/solr3 bash
sudo docker run --name Solr3 -t -i -p 8983:8983 ducdebreme/solr3 bash

# ====== next steps in container
bash /root/start.sh &




# ====== start for dev
sudo docker ps -a
CONTAINER ID        IMAGE                      COMMAND             CREATED             STATUS                       PORTS               NAMES
70bb4e13542c        ducdebreme/lamp53:latest   bash                18 minutes ago      Exited (255) 6 minutes ago                       Drupal6
sudo docker start Drupal6
sudo docker attach Drupal6
bash /root/start.sh &

