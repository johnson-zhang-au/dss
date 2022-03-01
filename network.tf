resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = local.common_tags
}

resource "aws_subnet" "main" {
  count      = length(var.vpc_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_subnets[count.index].subnet_index

  tags = local.common_tags
}
