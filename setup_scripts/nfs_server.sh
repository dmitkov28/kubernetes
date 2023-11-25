#!/bin/bash

echo '* Create shared directory ...'
mkdir /nfs_data
mkdir -p /nfs_data/{k8spva,k8spvb,k8spvc}
chmod -R 777 /nfs_data

echo '* Install nfs server ...'
apt update && apt install -y nfs-kernel-server

echo '* Edit /etc/exports ...'
echo '/nfs_data 192.168.200.0/255.255.255.0(rw,sync,no_subtree_check)' >> /etc/exports

echo '* Restart nfs server ...'
systemctl restart nfs-kernel-server


