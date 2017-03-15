#!/bin/bash

service docker stop

apt-get -y purge docker-engine

rm -rf /var/lib/docker

rm -f /etc/docker/daemon.json
