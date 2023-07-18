#!/bin/bash
set -x 
if [[ -z  ${1} ]]; then
        echo "Please provide a IAM user name"
else
        user="${1}"
fi
userKeyId=`aws iam list-ssh-public-keys --user-name "${user}"  --query "SSHPublicKeys[?Status == 'Active'].[SSHPublicKeyId]" --output text`
if [[ -z ${userKeyId} ]]; then
        echo "The user does not have an ssh key in its IAM user"
else
        aws iam get-ssh-public-key --user-name "${user}" --ssh-public-key-id "${userKeyId}" --encoding SSH --query "SSHPublicKey.SSHPublicKeyBody" --output text > /home/${user}/.ssh/authorized_keys
        /bin/chmod 600 /home/${user}/.ssh/authorized_keys
fi
chown $user: /home/$user -R
chmod 700 /home/$user /home/$user/.ssh
chmod 600 /home/$user/.ssh/authorized_keys