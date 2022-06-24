#########################################
#		Modules			#
#########################################

module "s3" {
  source = "./s3"
  # Vpc_name is basically your name or surname to keep resources unique in aws. You should chnage 'mukesh' to 'your-name'.
  # 'mukesh' will be taken as prefix for your cluster name also, 'mukesh.k8s' in this case.
  vpc_name = "mukesh"
}

module "vpc" {
  source   = "./vpc"
  vpc_name = "${module.s3.customer_or_your_name}"
}

module "controller" {
  source    = "./controller"
  vpc_name  = "${module.s3.customer_or_your_name}"
  vpc_id    = "${module.vpc.vpc_id}"
  subnet_id = "${module.vpc.subnet_id}"
}

module "route53" {
  source       = "./route53"
  vpc_id       = "${module.vpc.vpc_id}"
  cluster_name = "${module.s3.customer_or_your_name}.k8s"
}

#########################################
#		Outputs			#
#########################################

output "s3_bucket_name" {
  value = "${module.s3.s3_bucket_id}"
}

output "controller_instance_id" {
  value = "${module.controller.controller_instance_id}"
}

output "controller_public_ip" {
  value = "${module.controller.controller_public_ip}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "cluster_name" {
  value = "${module.route53.cluster_name}"
}
