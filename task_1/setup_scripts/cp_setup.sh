#!/bin/bash

echo '* Initializing cluster...'
sudo kubeadm init --apiserver-advertise-address=192.168.200.100 --pod-network-cidr 10.244.0.0/16

echo "* Copy configuration for root ..."
mkdir -p /root/.kube
cp -i /etc/kubernetes/admin.conf /root/.kube/config
chown -R root:root /root/.kube

echo "* Copy configuration for vagrant ..."
mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

echo "* Install Pod Network plugin (Calico) ..."
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.3/manifests/tigera-operator.yaml
wget -q https://raw.githubusercontent.com/projectcalico/calico/v3.26.3/manifests/custom-resources.yaml -O /tmp/custom-resources.yaml
sed -i 's/192.168.0.0/10.244.0.0/g' /tmp/custom-resources.yaml
kubectl create -f /tmp/custom-resources.yaml