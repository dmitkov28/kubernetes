#!/bin/bash

echo '* Joining cluster...'
kubeadm join 192.168.200.100:6443 --token $(cat /vagrant/token.txt) \
--discovery-token-ca-cert-hash sha256:$(cat /vagrant/hash.txt)