#!/bin/bash

# update 
sudo yum update -y

# install amazon-linux-extras epel 
sudo amazon-linux-extras install epel -y

# Add jenkins SSH key
echo `cat /tmp/tf-packer.pub` >> ~/.ssh/authorized_keys

# Connect to your instance without SSH keys & Configure sessions on the Session Manager
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm"
sudo yum install -y session-manager-plugin.rpm
sudo yum install -y https://s3.eu-west-1.amazonaws.com/amazon-ssm-eu-west-1/latest/linux_amd64/amazon-ssm-agent.rpm
