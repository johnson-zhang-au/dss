DkuOwner = "Johnson Zhang"
vpc = {
  cidr_block = "10.0.0.0/16"
  name = "jz-vpc"
}
vpc_subnets = [ {
  cidr_block = "10.0.0.0/24"
  subnet_index = 0
  name = "subnet01"
} ]
igw_name = "jz-igw"
ec2 = {
  instance_type = "t3.xlarge"
  name = "jz-dss"
}
ec2_interface = {
  name = "jz-dss-nic"
  private_ips = [ "10.0.0.4" ]
  subnet_index = 0
}
key_name = "johnsonz-key"
my_ip = "49.178.105.115/32"