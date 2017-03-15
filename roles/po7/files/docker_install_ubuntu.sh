#!/bin/bash

echo "start docker install"


add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main"

apt-get -y install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -

apt-get -y update

apt-get -y install docker-engine

touch /etc/docker/daemon.json

echo '{ "insecure-registries":["192.168.2.198:5000"] }' >> /etc/docker/daemon.json
 
service docker stop

service docker start
