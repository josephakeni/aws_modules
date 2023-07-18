#!/bin/bash

# Ansible Installation on Amazon Linux(EC2)
#sudo amazon-linux-extras install ansible2 -y

sudo cat << EOF >> /etc/sudoers
jenkins    ALL=NOPASSWD: ALL
EOF

sudo apt-get update -y
sudo apt-get install python3-pip
pip install --user boto3

sudo su - jenkins
python3 -m pip install boto3