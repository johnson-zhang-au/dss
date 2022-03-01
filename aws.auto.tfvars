DkuOwner = "Johnson Zhang"
vpc = {
  cidr_block = "10.0.0.0/16"
  name = "jz-vpc"
}
vpc_subnets = [ {
  cidr_block = "10.0.0.0/24"
  subnet_index = 1
  name = "subnet01"
} ]
ec2 = [ {
  instance_type = "t3.xlarge"
  name = "jz-dss"
} ]
ec2_interface = [ {
  name = "jz-dss-nic"
  private_ips = [ "10.0.0.4" ]
} ]
key_name = "johnsonz-key"