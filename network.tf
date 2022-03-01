

resource "aws_vpc" "main" {
  cidr_block       = var.vpc.cidr_block
  instance_tenancy = "default"
  tags = merge(
      local.common_tags,
      {
      "Name" = var.vpc.name
      },
  )
}

resource "aws_subnet" "main" {
  count      = length(var.vpc_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_subnets[count.index].cidr_block
  map_public_ip_on_launch = true

  tags = merge(
      local.common_tags,
      {
      "Name" = var.vpc_subnets[count.index].name
      },
  )
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
      local.common_tags,
      {
      "Name" = var.igw_name
      },
  )
}

resource "aws_route_table" "jz-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


   tags = local.common_tags
}
