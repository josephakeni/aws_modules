#!/usr/bin/env bash
set -e

echo "🚀 Installing base applications..."
apt-get update -y
apt-get install -y vim curl wget net-tools unzip git docker-compose 
# sudo apt-get-get install qemu-guest-agent  -y
# systemctl enable qemu-guest-agent
# systemctl start qemu-guest-agent
wget https://releases.hashicorp.com/terraform/1.11.0/terraform_1.11.0_linux_amd64.zip
unzip terraform_1.11.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
echo "✅ Installation complete."
