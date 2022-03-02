resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id
  tags = merge(
      local.common_tags,
      {
      "Name" = "allow_ssh"
      },
  )
}

resource "aws_security_group" "allow_eks" {
  name        = "allow_eks"
  description = "Allow dss inbound traffic from eks"
  vpc_id      = aws_vpc.main.id
  tags = merge(
      local.common_tags,
      {
      "Name" = "allow_eks"
      },
  )
}

resource "aws_security_group" "allow_dss" {
  name        = "allow_dss"
  description = "Allow dss inbound traffic"
  vpc_id      = aws_vpc.main.id
  tags = merge(
      local.common_tags,
      {
      "Name" = "allow_dss"
      },
  )
}


resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.my_ip
  security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.my_ip
  security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.my_ip
  security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0",]
  security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_security_group_rule" "allow_eks" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = var.my_ip
  security_group_id = aws_security_group.allow_dss.id
}