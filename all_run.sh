#!/bin/bash

#ansible-playbook auto_run_init.yml -e "hosts=iaas"
#ansible-playbook auto_run_db.yml -e "hosts=db"
#ansible-playbook auto_run_po.yml -e "hosts=master"

#ansible-playbook auto_run_init.yml -e "hosts=compute" -v 
#ansible-playbook auto_run_compute.yml -e "hosts=compute" -v

ansible-playbook auto_run_db_manual.yml -e "hosts=db" -v
