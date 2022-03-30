# 1. Deploy metrics server first
# 2. Run below command to test auto-scaling of database pod
while true; do wget -q -O- http://10.101.90.75:3306; done
