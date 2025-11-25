#!/usr/bin/env bash
set -e

echo "🚀 Installing base applications..."
sudo apt-get update -y
#!/bin/bash
# common.sh
# copy this script and run in all master and worker nodes
#i1) Switch to root user [ sudo -i]

#2) Disable swap & add kernel settings
sudo apt-get install -y containerd
sudo mkdir /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo sed -i 's/^#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF


#5) Installing kubeadm, kubelet and kubectl
# When building golden images or provisioning EC2/Proxmox VMs, always include a “APT lock wait” or “APT safe update”
sudo systemctl stop apt-daily.timer apt-daily-upgrade.timer
sudo systemctl mask apt-daily.service apt-daily-upgrade.service
sleep 10

# Update the apt package index and install packages needed to use the Kubernetes apt repository:
sudo apt-get update -y

sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

# Download the Google Cloud public signing key:

sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring

# Add the Kubernetes apt repository:

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.34/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly

# Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl 
sudo apt-get install -y docker.io docker-compose

# apt-mark hold will prevent the package from being automatically upgraded or removed.

sudo apt-mark hold kubelet kubeadm kubectl

# Enable and start kubelet service

sudo systemctl daemon-reload
sudo systemctl start kubelet
sudo systemctl enable kubelet.service
echo "✅ Installation complete."
