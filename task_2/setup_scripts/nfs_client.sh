#!/bin/bash

echo '* Install nfs client ...'
apt update && apt install -y nfs-common

echo '* Create & mount common directory ...'
mkdir /nfs_data
sudo mount 192.168.200.103:/nfs_data /nfs_data