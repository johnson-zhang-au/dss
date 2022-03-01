DkuOwner = "Johnson Zhang"
vpc = {
  cidr_block = "10.0.0.0/16"
  name = "jz-vpc"
}
vpc_subnets = [ {
  cidr_block = "10.0.0.0/24"
  subnet_index = 1
} ]