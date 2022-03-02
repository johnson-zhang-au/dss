DkuOwner = "Johnson Zhang"
vpc = {
  cidr_block = "10.0.0.0/16"
  name = "johnsonz-vpc"
}
vpc_subnets = [ {
  cidr_block = "10.0.0.0/24"
  subnet_index = 0
  name = "subnet01"
},
{
  cidr_block = "10.0.1.0/24"
  subnet_index = 1
  name = "subnet02"
},
{
  cidr_block = "10.0.2.0/24"
  subnet_index = 2
  name = "subnet03"
} ]
igw_name = "johnsonz-igw"
ec2 = {
  instance_type = "t3.xlarge"
  name = "johnsonz-dss"
}

rt_name = "johnsonz-rt"
ec2_interface = {
  name = "johnsonz-dss-nic"
  private_ips = [ "10.0.0.4" ]
  subnet_index = 0
}
az_name = "ap-southeast-1c"
ebs_vol = {
  name = "johnsonz-dss-data"
  size = 100
}
key_name = "johnsonz-key"
my_ip = ["49.178.105.115/32","1.147.94.21/32","1.147.116.73/32"]
ecr = {
  image_tag_mutability = "MUTABLE"
  name = "johnson-dss"
  scan_on_push = false
}
instance_profile = {
  iam_policy_suffix = "johnsonz-dss"
  iam_role_name = "johnsonz-dss-instance-prfole-role"
  name = "johnsonz-dss-instance-prfole"
}