#!/bin/bash
set -e

# update 
sudo apt-get update -y
# install git
sudo apt-get install git -y 

# install ansible on Ubuntu:
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
sudo apt install python3-apt -y

# Install necessary dependencies
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get -y -qq install curl wget git vim apt-transport-https ca-certificates ####
sudo add-apt-repository ppa:longsleep/golang-backports -y
sudo apt -y -qq install golang-go

# Setup sudo to allow no-password sudo for "hashicorp" group and adding "jenkins" user
sudo groupadd -r hashicorp
sudo useradd -m -s /bin/bash jenkins
sudo usermod -a -G hashicorp jenkins
sudo cp /etc/sudoers /etc/sudoers.orig
echo "jenkins ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins

# Installing SSH key
sudo mkdir -p /home/jenkins/.ssh
sudo chmod 700 /home/jenkins/.ssh
sudo cp /tmp/tf-packer /home/jenkins/.ssh/id_rsa
sudo chmod 0600 /home/jenkins/.ssh/id_rsa
sudo cp /tmp/tf-packer.pub /home/jenkins/.ssh/id_rsa.pub
sudo cp /tmp/tf-packer.pub /home/jenkins/.ssh/authorized_keys
sudo chmod 600 /home/jenkins/.ssh/authorized_keys
sudo chown -R jenkins:jenkins /home/jenkins/.ssh
sudo usermod --shell /bin/bash jenkins



sudo apt-get install python3-pip -y
sudo pip3 --version
sudo -H pip3 install --user boto3
sudo -H pip3 install boto3

# Create GOPATH for jenkins user & download the webapp from GitHub
go install github.com/hashicorp/learn-go-webapp-demo@latest

# Remove the conflicting Jenkins APT key:
sudo apt-key del 0xKEY_ID

# Install terraform
wget https://releases.hashicorp.com/terraform/1.2.5/terraform_1.2.5_linux_amd64.zip
sudo apt install zip -y
sudo unzip terraform_1.2.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Install Packer
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update -y && sudo apt-get install packer -y