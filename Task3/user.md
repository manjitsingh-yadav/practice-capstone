sudo useradd -m manjit -s /bin/bash
sudo passwd manjit
cd /home/manjit/
sudo openssl genrsa -out manjit.key 2048
sudo openssl req -new -key manjit.key -out manjit.csr -subj "/CN=manjit"
sudo openssl x509 -req -in manjit.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out manjit.crt -days 500
mkdir .certs
sudo mv manjit.key .certs/
sudo mv manjit.crt .certs/
kubectl config set-credentials manjit --client-certificate=/home/manjit/.certs/manjit.crt --client-key=/home/manjit/.certs/manjit.key
kubectl config set-context manjit-context --cluster=kubernetes --user=manjit
sudo cp /home/labsuser/.kube/config /home/manjit/.kube/
sudo chown -R manjit: /home/manjit/
