resource "aws_vpc" "main" {
  cidr_block       = var.vpc.cidr_block
  instance_tenancy = "default"
  tags = local.common_tags + {
      "name" = var.vpc.name
  }
}

resource "aws_subnet" "main" {
  count      = length(var.vpc_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_subnets[count.index].cidr_block

  tags = local.common_tags
}
