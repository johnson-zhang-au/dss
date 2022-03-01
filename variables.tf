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
            name = string
        }
    ))
  
}

variable "ec2" {
  type = list(object(
      {
          name = string
          instance_type = string
      }
  ))
}

variable "ec2_interface" {
  type = list(object({
      name = string
      private_ips = list(string)
  }))
}
variable "key_name" {
  type = string
}

variable "public_key" {
  type = string
  sensitive = true
}