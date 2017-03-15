#!/bin/bash

# help
help() {
    echo -e "\033[1mOPTIONS\033[0m"
    echo -e "       -h      help"
    echo -e "       -o      option"
    echo -e "       none    use default setting"
    exit 0
}

# set argument

while getopts "o:h" opt
do
    case $opt in
        o) action=$OPTARG >&2
          ;;
        h) help ;;
        "") help ;;
        ?) help ;;
    esac
done

shift $(( $OPTIND -1 ))

echo $action
source run.conf
# run
if [ "$action" = "init" ]; then
    ansible-playbook auto_run.yml -i /etc/ansible/hosts -e "option=$action hosts=$host user=$user"
elif [ "$action" = "run_db" ]; then
    ansible-playbook auto_run.yml -i /etc/ansible/hosts -e "option=$action hosts=$host user=$user tid=$tiberoid tpw=$tiberopw tport=$tiberoport"

elif [ "$action" = "run_po" ]; then
    ansible-playbook auto_run.yml -i /etc/ansible/hosts -e "option=$action hosts=$host user=$user tid=$tiberoid tpw=$tiberopw tport=$tiberoport t_ip=$tiberoip po_webadminport=$powebadminport po_webport=$powebport"

elif [ "$action" = "run_all" ]; then
    ansible-playbook auto_run.yml -i /etc/ansible/hosts -e "option=$action hosts=$host user=$user tid=$tiberoid tpw=$tiberopw tport=$tiberoport tip=$tiberoip po_webadminport=$powebadminport po_webport=$powebport"

elif [ "$action" = "test" ]; then
    ansible-playbook test.yml -i /etc/ansible/hosts -e "option=$action hosts=$host user=$user"

elif [ "$action" = "delete" ]; then
    ansible-playbook delete.yml -i /etc/ansible/hosts -e "option=$action hosts=$host user=$user"
else
    ansible-playbook auto_run.yml -i /etc/ansible/hosts -e "option=$action hosts=$host user=$user tid=$tiberoid tpw=$tiberopw tport=$tiberoport tip=$tiberoip po_webadminport=$powebadminport po_webport=$powebport"
fi
