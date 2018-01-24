#!/bin/bash

perl -i -pe 's/git:/https:/' /root/CRI_XCBC/install_ansible.sh

mkdir /root/.ssh
chmod 700 /root/.ssh

ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P ""

cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

perl -i -pe 's/\s*\#?\s*PasswordAuthentication\s+\S+\s*$/PasswordAuthentication yes\n/g' /etc/ssh/sshd_config

systemctl reload sshd

perl -i -pe 's/(^\s+hosts:.*)/$1\n   ignore_errors: yes\n/' /root/CRI_XCBC/headnode.yml

perl -i -pe "s/^headnode(.*)/${HOSTNAME}\$1/" /root/CRI_XCBC/inventory/headnode

