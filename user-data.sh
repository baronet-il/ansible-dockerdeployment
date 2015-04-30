#!/bin/bash
set -e -x

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# user-data is run as root, no need to sudo in this

ansible-pull --checkout="master" \
    --directory="/home/ec2-user/user-data" \
    --extra-vars="alternate_hosts=127.0.0.1" \
    --inventory-file="/home/ec2-user/user-data/ansible/local" \
    --module-name="git" \
    --purge \
    --url="https://github.com/baronet-il/ansible-dockerdeployment.git" \
    ansible/app.yml
