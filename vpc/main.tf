locals {
  source_vpc_name        = "${var.vpc_name}-${var.namespace}-vpc"
  source_subnet_name     = "${var.vpc_name}-${var.namespace}-public-sbunet"
  source_igw_name        = "${var.vpc_name}-${var.namespace}-igw"
  source_rt              = "${var.vpc_name}-${var.namespace}-rt"
}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr}"
  enable_dns_support = "true" 
  enable_dns_hostnames = "true" 
  enable_classiclink = "false"
  instance_tenancy = "default"    
  tags = {
      Name = local.source_vpc_name
  }
  provisioner "local-exec" {
  command = "echo ${aws_vpc.vpc.id} > /tmp/vpc_id.txt"
  }

}

resource "aws_subnet" "public-subnet-1" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${var.subnet_cidr}"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.avail_zone}"
    tags = {
        Name = local.source_subnet_name
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags = {
        Name = local.source_igw_name
    }
}

resource "aws_route_table" "public-rt" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "${var.global_ip}"
      gateway_id = "${aws_internet_gateway.igw.id}"
    }
    tags = {
        Name = local.source_rt
    }
}

resource "aws_route_table_association" "rt-public-subnet-association"{
    subnet_id = "${aws_subnet.public-subnet-1.id}"
    route_table_id = "${aws_route_table.public-rt.id}"
}
