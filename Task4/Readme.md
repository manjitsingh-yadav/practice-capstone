# 1. Run below command to create the secret required to enable image pulling from private repository
kubectl create secret docker-registry regcred --docker-server=https://index.docker.io/v1/ --docker-username=manjitsinghyadav --docker-password=XXXXXXXX --docker-email=XXXXXXXXX@gmail.com
