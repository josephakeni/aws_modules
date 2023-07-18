#!/bin/bash

# update
sudo yum update -y 
# install Apache
sudo yum install httpd -y
sudo service httpd start
