docker-lamp
===========

Provides a docker base LAMP container.

sudo docker build -t  ducdebreme/lamp53 .


sudo docker run -t -i -v $(pwd)/tmp:/var/log -p 80:80  ducdebreme/lamp53 bash

# in container
bash /root/start.sh &