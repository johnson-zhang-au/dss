data "aws_ami" "centos" {
  most_recent = true
  owners      = ["679593333241"] # CentOS

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

resource "aws_network_interface" "dss" {
  subnet_id   = aws_subnet.main.id
  private_ips = var.ec2_interface.private_ips

  tags = merge(
      local.common_tags,
      {
      "Name" = var.ec2_interface.name
      },
  )
}

resource "aws_instance" "dss" {
  ami           = data.aws_ami.centos.id
  instance_type = var.ec2.instance_type

  network_interface {
    network_interface_id = aws_network_interface.dss.id
    device_index         = 0
  }

   credit_specification {
    cpu_credits = "unlimited"
  }

  key_name = aws_key_pair.key.name 

  tags = merge(
      local.common_tags,
      {
      "Name" = var.ec2.name
      },
  )
}