#!/usr/bin/env bash
# finalize-template.sh
# Usage: ./finalize-template.sh <proxmox_host> <vm_name> [storage_name]

set -euo pipefail

PROXMOX_HOST=${1:-192.168.0.3}
VM_NAME=${2:-packer-test}
STORAGE=${3:-local-lvm}
SSH_KEY_PATH="files/id_rsa.pub"

echo "==> Connecting to Proxmox host: ${PROXMOX_HOST}"
echo "==> Target VM name: ${VM_NAME}"
echo "==> Storage for Cloud-Init: ${STORAGE}"

# 1. Get VMID dynamically from VM name
VMID=$(ssh -o StrictHostKeyChecking=no root@"${PROXMOX_HOST}" \
  "pvesh get /cluster/resources --type vm --output-format json" |
  jq -r ".[] | select(.name==\"${VM_NAME}\") | .vmid")

if [[ -z "${VMID}" ]]; then
  echo "❌ Could not find VM named ${VM_NAME} on ${PROXMOX_HOST}"
  exit 1
fi

echo "==> Found VMID: ${VMID}"

# 2. Attach Cloud-Init drive (if not already attached)
ssh -o StrictHostKeyChecking=no root@"${PROXMOX_HOST}" \
  "qm config ${VMID} | grep -q cloudinit || qm set ${VMID} --ide2 ${STORAGE}:cloudinit"

# 3. Enable serial console for Cloud-Init
ssh -o StrictHostKeyChecking=no root@"${PROXMOX_HOST}" \
  "qm set ${VMID} --serial0 socket --vga serial0"

# 4. Configure Cloud-Init to use DHCP
ssh -o StrictHostKeyChecking=no root@"${PROXMOX_HOST}" \
  "qm set ${VMID} --ipconfig0 ip=dhcp"

# 5. Inject your SSH public key
if [[ -f "${SSH_KEY_PATH}" ]]; then
  echo "==> Adding SSH public key from ${SSH_KEY_PATH}"
  ssh -o StrictHostKeyChecking=no root@"${PROXMOX_HOST}" \
    "qm set ${VMID} --sshkey <(cat ${SSH_KEY_PATH})"
else
  echo "⚠️ No SSH key found at ${SSH_KEY_PATH}, skipping"
fi

# 6. Optional: ensure agent is enabled
ssh -o StrictHostKeyChecking=no root@"${PROXMOX_HOST}" \
  "qm set ${VMID} --agent enabled=1"

# 7. (Optional) finalize as template if it's still a VM
ssh -o StrictHostKeyChecking=no root@"${PROXMOX_HOST}" \
  "if ! qm config ${VMID} | grep -q 'template: 1'; then qm template ${VMID}; fi"

echo "✅ Template ${VM_NAME} (VMID ${VMID}) finalized successfully!"
