#!/bin/bash -xe
exec > /var/log/controller-userdata.log 2>&1
set +e


apt-get update -y
apt-get install tree jq vim python3-pip docker.io -y
apt-get install awscli -y

###### Install Kops #########

curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/kops

###### Install Kubectl ##########

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

####### Install helm ##########
curl -LO https://get.helm.sh/helm-v3.9.0-linux-amd64.tar.gz
tar -zxvf helm-v3.9.0-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm

######## Export env variables ########

#export buck_name=`aws s3 ls | awk '{print $3}' | grep -i 'k8s-files'`
#export NODE_COUNT=2
#export NODE_SIZE="t3.medium"
#export MASTER_COUNT=1
#export MASTER_SIZE="t3.medium"
#export CLUSTER_NAME="mukesh.k8s"
#export VPC_ID=`cat /tmp/vpc_id.txt`

############ Create k8s cluster #############

#kops create cluster --name=$CLUSTER_NAME --state=s3://$buck_name --node-count=$NODE_COUNT --node-size=$NODE_SIZE --master-count=$MASTER_COUNT --master-size=$MASTER_SIZE --vpc=$VPC_ID --zones=us-east-1b,us-east-1c --dns=private --yes

#kops update cluster --yes
