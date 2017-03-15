#!/bin/bash
service docker stop

systemctl stop docker

systemctl stop ntpd

yum -y remove ntp


yum -y remove docker
yum -y remove docker-common
yum -y remove container-selinux
yum -y remove docker-selinux
yum -y remove docker-engine

rm -rf /var/lib/docker

