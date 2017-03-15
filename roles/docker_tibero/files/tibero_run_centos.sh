#!/bin/bash

registry_ip=`awk '/insecure/{print $3}' /usr/lib/systemd/system/docker.service`
docker pull $registry_ip/tibero6 >> /root/automation/log/progress
docker run -it -d -p $TIBERO_PORT:8629 -v /root/automation/tibero/tibero_database:/root/tibero6/database --ipc=host -e t_id=$TIBERO_USER -e t_pw=$TIBERO_PW $registry_ip/tibero6:0.1 /bin/bash -c /root/tibero6/tibero_boot.sh >> /root/automation/log/progress
