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
  subnet_id   = aws_subnet.main[var.ec2_interface.subnet_index].id
  private_ips = var.ec2_interface.private_ips

  security_groups = [aws_security_group.allow_ssh.id,aws_security_group.allow_eks.id]

  tags = merge(
      local.common_tags,
      {
      "Name" = var.ec2_interface.name
      },
  )
}

resource "aws_ebs_volume" "data" {
  availability_zone = var.az_name
  size              = var.ebs_vol.size

  tags = merge(
      local.common_tags,
      {
      "Name" =  var.ebs_vol.name
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

  key_name = aws_key_pair.key.key_name 
  iam_instance_profile = aws_iam_instance_profile.dss_profile.name

  tags = merge(
      local.common_tags,
      {
      "Name" = var.ec2.name
      },
  )
}

resource "aws_volume_attachment" "data_ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.dss.id
}
