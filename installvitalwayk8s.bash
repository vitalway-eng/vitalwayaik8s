#!/bin/bash
sudo snap install k8s --classic
cat <<EOF | sudo k8s bootstrap --file -
containerd-base-dir: /custom/containerd/path
cluster-config:
  network:
    enabled: true
EOF
sudo k8s enable dns network ingress load-balancer local-storage gateway
sudo k8s status
sudo snap install kubectl --classic
