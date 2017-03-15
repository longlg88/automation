#!/bin/bash

cd automation/tibero/

if [ -z /root/automation/tibero/tibero_database ]; then
    echo "skip tar -xvf /root/automation/tibero/tibero_database.tar.gz"
else
    tar -xvf /root/automation/tibero/tibero_database.tar.gz
fi
