#!/bin/bash

# apt update && upgrade && remove unnecessary files
echo -e "apt update && upgrade && remove unnecessary files"
apt-get -y update

apt-get -y dist-upgrade

apt-get remove --auto-remove ubuntu-software libreoffice*

# apt install vim
echo -e "apt install vim"
apt-get -y install vim


# apt-get -y install sshpass
apt-get -y install sshpass

# apt install ntp
#echo -e "apt install ntp"
#apt-get -y install ntp

#if [ -z /etc/ntp.conf.backup ]; then
#    echo -e
#    echo -e "skip copy ntp conf backup files"
#else
#    echo "backup ntp conf files and setting new one"
#    cp /etc/ntp.conf /etc/ntp.conf.backup
#    sed -i -e 's/pool /server /g' /etc/ntp.conf
#    sed -i -e 's/ubuntu/asia/g' /etc/ntp.conf
#fi

