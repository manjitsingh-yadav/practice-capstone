# 1. Set AWS access key id and secret access key

export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""

Then run,
terraform apply

# 2. Run following commands on master node after first login

mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 3. Setup networking solution (Weave) on master node

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# 4. Run following command on master node to generate cluster join token

kubeadm token create --print-join-command --ttl 0

# 5. Above command will generate a join token command that needs to be run on worker nodes

kubeadm join xxx.xxx.xxx.xxx:6443 --token xkcj3k.vsp6fcdml1iqy9np --discovery-token-ca-cert-hash sha256:bd152a45820759f68337cbbeed8c20acd925cebf0c0ca8d3e0d81dc211b68d28
