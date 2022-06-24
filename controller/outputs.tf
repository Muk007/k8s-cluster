output "controller_instance_id" {
  value = aws_instance.controller.id
}

output "controller_public_ip" {
  value = aws_instance.controller.public_ip
}
