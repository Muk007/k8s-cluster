output "s3_bucket_id" {
  value = aws_s3_bucket.source_bucket.id
}

output "customer_or_your_name" {
  value = var.vpc_name
}
