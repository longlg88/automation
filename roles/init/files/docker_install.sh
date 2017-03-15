#!/bin/bash
yum -y update --skip-broken

yum-complete-transaction --cleanup-only

yum history redo last

tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

yum -y install docker-engine

if [ -z /root/automation/backup/docker.service ]; then
    echo -e
    echo -e "there is docker.service file"
else
    cp /usr/lib/systemd/system/docker.service /root/automation/backup/docker.service
    sed -i '/^ExecStart/c\ExecStart=/usr/bin/dockerd --insecure-registry 192.168.2.198:5000' /usr/lib/systemd/system/docker.service
fi

systemctl enable docker.service

systemctl start docker

service docker start
