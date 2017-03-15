#!/bin/bash

service docker stop

cd /root/automation/initial/docker_binary

tar -xvf ../docker_binary.tar

cp /root/automation/initial/docker_binary/docker /usr/bin/docker
cp /root/automation/initial/docker_binary/dockerd /usr/bin/dockerd
cp /root/automation/initial/docker_binary/docker-runc /usr/bin/docker-runc
cp /root/automation/initial/docker_binary/docker-proxy /usr/bin/docker-proxy
cp /root/automation/initial/docker_binary/docker-containerd /usr/bin/docker-containerd
cp /root/automation/initial/docker_binary/docker-containerd-ctr /usr/bin/docker-containerd-ctr
cp /root/automation/initial/docker_binary/docker-containerd-shim /usr/bin/docker-containerd-shim

service docker start
