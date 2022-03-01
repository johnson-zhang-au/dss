
output "ec2_public_ip" {
  value = aws_instance.dss.public_ip
}
