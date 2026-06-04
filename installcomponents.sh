#!/bin/bash
apt-get update && sudo apt-get install -y open-iscsi nfs-common
systemctl enable --now iscsid
helm repo add longhorn https://charts.longhorn.io
helm repo update
k8s helm upgrade --install longhorn longhorn/longhorn --namespace longhorn-system --create-namespace
k8s kubectl apply -f yamls/longhorn-storage-class.yaml
k8s kubectl apply -f yamls/redis-k8s.yaml
k8s kubectl apply -f yamls/ollama.yaml