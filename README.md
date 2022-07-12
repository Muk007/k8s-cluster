# Create k8s-cluster

1. Clone the repo and #**cd ./k8s-cluster**
2. Copy your public key into **./k8s-cluster/controller/files/id_rsa.pub**
3. If you want to give the cluster a different name, for example **'globallogic.k8s or my-cluster.k8s'**, you have to change **'vpc_name'** to **'globallgic or my-cluster'** in **./k8s-cluster/child_module.tf** file.
4. Now run #**terraform init && terraform apply -auto-approve**
5. You will see vpc_id, bucket_name, cluster_name, instance_public_ip in output, make a note of that.
6. Now ssh into controller #**ssh -i ./k8s-cluster/controller/files/id_rsa.pub ubuntu@<public_ip>**
7. Once logged into controller, run below command to create the cluster,

#**kops create cluster --name=$CLUSTER_NAME --state=s3://$S3_BUCKET --node-count=1 --node-size=t3.medium --master-count=1 --master-size=t2.small --zones us-east-1b,us-east-1c --vpc=$VPC --dns=private --yes**

#**kops update cluster --name=$CLUSTER_NAME --state=s3://$S3_BUCKET --yes**

Now log into the controller and pass below command to see the nodes in the cluster,

#**kubectl get nodes -o wide**

NOTE:
- cluster_name, vpc_id, controller_public_ip and bucket_name you get as output when you run terraform command, make a note of that.
- node_size and master_size can be any intance size, like "t3.medium or t2.small"
- node_count can be 2 or 3 and master_count should be 1. These counts should be as minimal as they can be **(1 < count <= 3)**  since this is just a setup for learning purpose only.


NOTE: Make sure to delete the cluster before signing off,

#**kops delete cluster --name=$CLUSTER_NAME --state=s3://$S3_BUCKET --yes**

**###### HAPPY LEARNING ######**
