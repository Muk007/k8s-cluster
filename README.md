<p align="center"><b>****** Create K8s Cluster ******</b></p>


1. Clone the repo and #**cd ./k8s-cluster**
2. Copy your public key into **./k8s-cluster/controller/files/id_rsa.pub**
3. If you want to give the cluster a different name, for example **'globallogic.k8s or my-cluster.k8s'**, you have to change **'vpc_name'** to **'globallgic or my-cluster'** in **./k8s-cluster/child_module.tf** file.
4. Now run,

#**terraform init && terraform apply -auto-approve**

5. You will see vpc_id, bucket_name, cluster_name, instance_public_ip in output, make a note of that.
6. Now ssh into controller 

#**ssh -i ./k8s-cluster/controller/files/id_rsa.pub ubuntu@<public_ip>**

7. Once logged into controller, run below command to create a cluster,

#**kops create cluster --name=<cluster_name> --state=s3://<bucket_name> --node-count=<node_count> --node-size=<node_size> --master-count=<master_count> --master-size=<master_size> --vpc=<vpc_id> --zones=us-east-1b,us-east-1c --dns=private --yes**

#**kops update cluster --name=<cluster_name> --state=s3://<bucket_name> --yes**

NOTE:
- cluster_name, vpc_id, controller_public_ip and bucket_name you get as output when you run terraform command, make a note of that.
- node_size and master_size can be any intance size, like "t3.medium or t2.small"
- node_count can be 2 or 3 and master_count should be 1. These counts should be as minimal as they can be **(1 < count <= 3)**  since this is just a setup for learning purpose only.

8. Once you are done with the cluster, make sure to delete the cluster using below command,

#**kops delete cluster --name=<cluster_name> --state=s3://<bucket_name> --yes**

9. Now, you can run below command to clean all resources.

#**terraform destroy -auto-approve**


<p align="center"><b>****** Happy Learning ******</b></p>
