#!/bin/bash

# update 
sudo yum update -y
# install nginx
sudo amazon-linux-extras install nginx1.12 -y 
sudo systemctl start nginx
