#!/bin/bash

nvidia-ctk runtime configure --runtime=containerd
systemctl restart containerd

helm repo add nvdp https://nvidia.github.io/k8s-device-plugin
helm repo update
k8s helm upgrade -i nvdp nvdp/nvidia-device-plugin   --namespace nvidia-device-plugin   --set nodeSelector=null


apt-get update && sudo apt-get install -y open-iscsi nfs-common
systemctl enable --now iscsid

helm repo add longhorn https://charts.longhorn.io
helm repo update
k8s helm upgrade --install longhorn longhorn/longhorn --namespace longhorn-system --create-namespace

k8s kubectl apply -f yamls/longhorn-storage-class.yaml
k8s kubectl apply -f yamls/redis-k8s.yaml
k8s kubectl apply -f yamls/mysql.yaml
#k8s kubectl apply -f yamls/ollama.yaml

k8s kubectl create secret docker-registry github-registry-pull-secret --docker-server=https://ghcr.io   --docker-username=vitalway-eng --docker-password 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   --docker-email=kuldeep.apte@vitalway.ai   --namespace=vitalwayai
k8s kubectl apply -f yamls/pickdocstoinfere.yml
 
mysql -u root -p -h 192.168.8.55 -e "CREATE USER 'root'@'192.168.8.54' IDENTIFIED BY 'Vtw123$%^'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.8.54' WITH GRANT OPTION; FLUSH PRIVILEGES;"