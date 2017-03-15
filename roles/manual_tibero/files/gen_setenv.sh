#!/bin/bash

if [ -f /root/automation/db_files/setenv ]; then
    echo "skip generate"
    exit
else
    touch /root/automation/db_files/setenv
fi

setenv=/root/automation/db_files/setenv

echo "export TB_HOME=$TB_HOME" >> $setenv
echo "export TB_SID=$TB_SID" >> $setenv
echo 'export LD_LIBRARY_PATH=$TB_HOME/lib:$TB_HOME/client/lib' >> $setenv
echo 'export PATH=$PATH:$TB_HOME/bin:$TB_HOME/client/bin' >> $setenv
