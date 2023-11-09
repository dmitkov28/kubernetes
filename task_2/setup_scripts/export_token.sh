#!/bin/bash

echo '* Exporting token...'
sudo echo $(kubeadm token list | awk 'NR==2{print $1}') > /vagrant/token.txt

echo '* Exporting hash...'
sudo echo $(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | \
   openssl dgst -sha256 -hex | sed 's/^.* //') > /vagrant/hash.txt