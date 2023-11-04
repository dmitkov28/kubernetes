#!/bin/bash

echo "* Create group gurus ..."
groupadd gurus

echo "* Create users Ivan & Mariana ..."
useradd -m -s /bin/bash -g gurus -c Ivan ivan
useradd -m -s /bin/bash -g gurus -c Mariana mariana  

echo "* Create certificates ..."

# Ivan
mkdir -p /home/ivan/.certs
openssl genrsa -out /home/ivan/.certs/ivan.key 2048
openssl req -new -key /home/ivan/.certs/ivan.key -out /home/ivan/.certs/ivan.csr -subj "/CN=ivan"
openssl x509 -req -in /home/ivan/.certs/ivan.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out /home/ivan/.certs/mariana.crt -days 365

# Mariana
mkdir -p /home/mariana/.certs
openssl genrsa -out /home/mariana/.certs/mariana.key 2048
openssl req -new -key /home/mariana/.certs/mariana.key -out /home/mariana/.certs/mariana.csr -subj "/CN=mariana"
openssl x509 -req -in /home/mariana/.certs/mariana.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out /home/mariana/.certs/mariana.crt -days 365

echo "* Create kubernetes users ..."
kubectl config set-credentials ivan --client-certificate=/home/ivan/.certs/ivan.crt --client-key=/home/ivan/.certs/ivan.key
kubectl config set-context ivan-context --cluster=kubernetes --user=ivan

kubectl config set-credentials mariana --client-certificate=/home/mariana/.certs/mariana.crt --client-key=/home/mariana/.certs/mariana.key
kubectl config set-context mariana-context --cluster=kubernetes --user=mariana

echo "* Create kubeconfig files ..."

CA_CERTIFICATE="/etc/kubernetes/pki/ca.crt"
CLUSTER_SERVER="https://192.168.200.100:6443"

cat <<EOF > "/home/ivan/.kube/config"
apiVersion: v1
clusters:
- cluster:
    certificate-authority: $CA_CERTIFICATE
    server: $CLUSTER_SERVER
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: ivan
  name: ivan-context
current-context: ivan-context
kind: Config
preferences: {}
users:
- name: ivan
  user:
    client-certificate: /home/ivan/.certs/ivan.crt
    client-key: /home/ivan/.certs/ivan.key
EOF

cat <<EOF > "/home/mariana/.kube/config"
apiVersion: v1
clusters:
- cluster:
    certificate-authority: $CA_CERTIFICATE
    server: $CLUSTER_SERVER
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: mariana
  name: mariana-context
current-context: mariana-context
kind: Config
preferences: {}
users:
- name: mariana
  user:
    client-certificate: /home/mariana/.certs/mariana.crt
    client-key: /home/mariana/.certs/mariana.key
EOF


chown -R mariana: /home/mariana
chown -R ivan: /home/ivan