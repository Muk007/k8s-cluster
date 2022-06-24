locals {
  source_bucket_name        = "${var.vpc_name}-${var.namespace}-k8s-files"
}

resource aws_s3_bucket source_bucket {
  bucket          = local.source_bucket_name
  force_destroy   = true
  tags = {
    Name = local.source_bucket_name
  }
  provisioner "local-exec" {
  command = "echo ${aws_s3_bucket.source_bucket.id} >> /tmp/bucket_name.txt"
  }
}
