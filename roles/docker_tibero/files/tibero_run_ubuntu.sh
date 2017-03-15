#!/bin/bash

touch registry

echo `awk -F: '/insecure/{print $2}' /etc/docker/daemon.json` > registry


registry_ip=`sed 's/[[]["]//g' registry`:5000

rm -f registry

#touch file

#docker images >> file


docker pull $registry_ip/$DB_IMAGE_NAME >> /root/automation/log/progress
docker run -it -d -p $TIBERO_PORT:8629 -v /root/automation/tibero/tibero_database:/root/tibero6/database --ipc=host -e t_id=$TIBERO_USER -e t_pw=$TIBERO_PW $registry_ip/$DB_IMAGE_NAME /bin/bash -c /root/tibero6/tibero_boot.sh >> /root/automation/log/progress
