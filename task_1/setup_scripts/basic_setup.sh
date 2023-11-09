#!/bin/bash

echo '* Load br_netfilter on boot ...'
modprobe br_netfilter
echo br_netfilter >> /etc/modules-load.d/k8s.conf

echo '* Adjust network-related settings and apply them ...'
cat << EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sysctl --system

echo '* Install iptables and switch it to legacy version ...'
apt-get update && apt-get install -y iptables
update-alternatives --set iptables /usr/sbin/iptables-legacy

echo '* Turn off the swap ...'
swapoff -a
sed -i '/swap/ s/^/#/' /etc/fstab

echo '* Add hosts ...'
echo '192.168.200.100 k8s-cp' >> /etc/hosts
echo '192.168.200.101 k8s-node1' >> /etc/hosts
echo '192.168.200.102 k8s-node2' >> /etc/hosts

echo '* Install other required packages ...'
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release