locals {
  resource_name_prefix   = "${var.vpc_name}-${var.namespace}-${var.stage}"
  sec_grp                = "${local.resource_name_prefix}_ssh_allowed"
}

resource "aws_key_pair" "k8s_key" {
  key_name        = "${var.vpc_name}_k8s_key"
  #public_key      = file("~/.ssh/id_rsa.pub")
  public_key      = file("${path.module}/files/id_rsa.pub")
}


resource "aws_security_group" "ssh-allowed" {
    vpc_id = var.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = local.sec_grp
    }
}

data "template_cloudinit_config" "controller" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/files/server-install.sh")
  }
}

data "aws_ami" "linux" {
  owners = ["099720109477"]
  filter {
    name   = "name"
    values = [lookup(var.ami_name, var.ubuntu_os_version)]
  }
}

resource "aws_iam_policy" "admin_policy" {
  name        = "${local.resource_name_prefix}-s3-admin-policy"
  path        = "/"
  description = "This policy is to describe s3"

  policy = jsonencode({

    "Version"= "2012-10-17",
    "Statement"= [
      {
        "Sid": "",
        "Action": "*",
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role" "iam-role" {
  name               = "${local.resource_name_prefix}-role"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": {"Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.iam-role.name
  policy_arn = aws_iam_policy.admin_policy.arn
}

resource "aws_iam_instance_profile" "iam-profile" {
  name = "${local.resource_name_prefix}-ec2-profile"
  role = aws_iam_role.iam-role.name
}

resource "aws_instance" "controller" {
  ami                    = data.aws_ami.linux.id
  instance_type          = var.controller_instance_type
  key_name               = aws_key_pair.k8s_key.id
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ssh-allowed.id]
  iam_instance_profile   = aws_iam_instance_profile.iam-profile.name
  user_data              = data.template_cloudinit_config.controller.rendered

  tags = {
    Name                 = "${local.resource_name_prefix}-controller-tf"
  }
}
