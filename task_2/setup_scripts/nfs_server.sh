#!/bin/bash

echo '* Create shared directory ...'
mkdir /nfs_data

echo '* Install nfs server ...'
apt update && apt install -y nfs-kernel-server

echo '* Edit nfs config ...'
echo '/nfs_data 192.168.200.0/255.255.255.0(rw)' >> /etc/exports

echo '* Restart nfs server ...'
systemctl restart nfs-kernel-server
