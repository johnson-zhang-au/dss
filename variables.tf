variable "DkuOwner" {
    type = string
}
variable "vpc_cidr" {
  type = string
}

variable "vpc_subnets" {
    type = list(object(
        {
            subnet_index = number
            cidr_block = string
        }
    ))
  
}

