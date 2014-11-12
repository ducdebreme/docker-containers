docker-lamp
===========

Provides a docker base LAMP container.

    docker build -t  ducdebreme/lamp55 .

## PUSH
    docker push ducdebreme/lamp55


# prepare
# provide a copy of .ssh which contains id_pub as authorized key
    sudo rm -rf ~/.ssh_docker
    mkdir ~/.ssh_docker
    cp ~/.ssh/id_rsa.pub ~/.ssh_docker/authorized_keys


# run as daemon
    docker/logs:/var/log -v ~/.ssh_docker:/root/.ssh -P ducdebreme/lamp55 

# terminal
    sudo docker run --name l55 -i -t -v $(pwd):/var/www -v $(pwd)/_docker/logs:/var/log -v ~/.ssh_docker:/root/.ssh -P ducdebreme/lamp55 bash