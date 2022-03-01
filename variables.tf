variable "DkuOwner" {
    type = string
}
variable "vpc" {
  type = object({
      name = string
      cidr_block = string
  })
}

variable "vpc_subnets" {
    type = list(object(
        {
            subnet_index = number
            cidr_block = string
        }
    ))
  
}

