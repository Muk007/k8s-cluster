variable "controller_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of EC2 instance"
}

variable "ami_name" {
  type = map
  default = {
    "18.04" = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20210128"
    "20.04" = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20211118"
  }
  description = "AMI names mapped to different ubuntu OS versions"
}

variable "ubuntu_os_version" {
  type = string
  default = "18.04"
  description = "ubuntu version"
}

variable "vpc_name" {
  type        = string
  description = "Customer or Your name"
}

variable "namespace" {
  type        = string
  default     = "local"
  description = "Namespace"
}

variable "stage" {
  description = "Stage"
  default     = "sandbox"
  type        = string
}

variable "vpc_id" {
  type = string
  description = "VPC id"
}

variable "subnet_id" {
  type = string
  description = "Public Subnet Id"
}
