apt-get update && sudo apt-get install -y open-iscsi nfs-common
systemctl enable --now iscsid

sudo snap install k8s --classic

sudo k8s get-join-token --worker [to run on existing cluster host]

sudo k8s join-cluster <join-token>
sudo k8s kubectl get nodes