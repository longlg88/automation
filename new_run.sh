#!/bin/bash

# help
help() {
    echo -e "Usage: ./new_run.sh [OPTIONS] COMMAND"
    echo -e "       ./new_run.sh [ --help] \n"
    echo -e "Automatically configuration service for cloud.\n"
    echo -e "Options: \n" 
    echo -e "   -H, --host         Use hosts groups"
    echo -e "   -h, --help         Print usage\n"
    echo -e "Commands:"
    echo -e "   init                        Initial settings"
    echo -e "   rundbmanual                 Run Tibero6 manual"
    echo -e "   rundb                       Run Tibero6 container" 
    echo -e "   runpo                       RUN PO7 container"
    echo -e "   runcompute                  Install lxc settings"
    echo -e "   runall(not recommended)     RUN ALL(init/rundb/runpo)"
    echo -e "   delete                      Delete all settings"

    #echo -e "\033[1mName\033[0m"
    #echo -e "Install & configuration automatically"
    #echo -e
    #echo -e "\033[1mOPTIONS\033[0m"
    #echo -e "-h      help"
    #echo -e "-o      option"
    #echo -e 
    #echo -e "options: init / rundb / runpo / runall / delete"
    #echo -e "ex) ./run.sh -o run_all"
    exit 0
}

# set argument

while getopts "H:-host:h:-help" opt
do
    opt="$1"
    case $opt in
        -H | --host) host="$2" action="$3"
        ;;
        -h | --help) help ;;
        ?) help ;;
        *) help ;;
    esac
done

shift $(( $OPTIND -1 ))


file="$(locate '*id_rsa')"
echo $file

if [ -f "$file" ]; then
	echo "$file exists."
else
	ssh-keygen
fi


host_count=`cat $PWD/hosts | grep -v "\[" | grep -v "\#" | grep -v "^$" | grep -v "[a-z]" | grep -v "[A-Z]" | wc -l`
echo $host_count


index=1
while [ $index -le $host_count ]
do
    host_ip=`cat $PWD/hosts | grep -v "\[" | grep -v "\#" | grep -v "^$" | sed -n "$index"'p'` 
    echo $host_ip
    ssh-copy-id root@"$host_ip" > temp 2>&1


    warning=`sed -n '/WARNING/p' temp`
    error=`sed -n '/ERROR/p' temp`
    
    if [[ "$error" =~ "ERROR" ]]; then
        echo "error"
        exit
    else
        echo "pass"
    fi

    if [[ "$warning" =~ "WARNING" ]]
    then
        echo "skip ssh copy id"
    else
        echo "pass"
    fi

    index=$(($index+1))
done


if [ "$action" = "init" ]; then
    ansible-playbook init.yml -e "hosts=$host" -v

elif [ "$action" = "rundbmanual" ]; then
    ansible-playbook db_manual.yml -e "hosts=$host" -v

elif [ "$action" = "rundb" ]; then
    ansible-playbook db_docker.yml -e "hosts=$host" -v

elif [ "$action" = "runpo" ]; then
    ansible-playbook po_docker.yml -e "hosts=$host" -v

elif [ "$action" = "runcompute" ]; then
    ansible-playbook compute.yml -e "hosts=$host" -v

elif [ "$action" = "runall" ]; then
    #ansible-playbook all.yml -e "hosts=$host" -v
    all_run.sh

elif [ "$action" = "test" ]; then
    ansible-playbook test.yml -e "hosts=$host" -v

elif [ "$action" = "delete" ]; then
    ansible-playbook delete.yml -e "hosts=$host" -v

elif [ "$action" = "deletedb" ]; then
	ansible-playbook delete_tibero.yml -e "hosts=$host" -v
else
    echo "Unrecongnized host : "$host "command : "$action
fi
