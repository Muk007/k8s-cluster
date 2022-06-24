resource "aws_route53_zone" "private" {
  name = var.cluster_name

  vpc {
   vpc_id = "${var.vpc_id}"
  }
}
