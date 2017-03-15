#!/bin/bash

echo "Time setting start ..." 

yum -y install ntp

echo "ntp.conf modifying ..."
if [ -z /etc/ntp.conf.backup ]; then
    echo -e
    echo -e "skip copy back ntp conf file"
else
    echo "back up file ntp.conf"
    cp /etc/ntp.conf /etc/ntp.conf.backup
    sed -i -e 's/centos/asia/g'  /etc/ntp.conf  
fi

firewall-cmd --add-service=ntp --permanent

firewall-cmd --reload

systemctl start ntpd

systemctl enable ntpd
