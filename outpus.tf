
output "ec2_public_ip" {
  value = aws_instance.dss.public_ip
}

output "ecr_url" {
  value = aws_ecr_repository.dss.repository_url 
}

output "subnets" {
  value = aws_subnet.main[*].id 
}
