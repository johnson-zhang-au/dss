variable "DkuOwner" {
  type = string
}
variable "vpc" {
  type = object({
    name       = string
    cidr_block = string
  })
}

variable "vpc_subnets" {
  type = list(object(
    {
      subnet_index = number
      cidr_block   = string
      name         = string
    }
  ))

}

variable "igw_name" {
  type = string
}

variable "rt_name" {
    type = string
}

variable "ec2" {
  type = object(
    {
      name          = string
      instance_type = string
    }
  )
}

variable "ec2_interface" {
  type = object({
    name         = string
    private_ips  = list(string)
    subnet_index = number
  })
}
variable "az_name" {
  type = string
}
variable "ebs_vol" {
  type = object({
      name = string
      size = number
  })
}
variable "key_name" {
  type = string
}

variable "public_key" {
  type      = string
  sensitive = true
}

variable "my_ip" {
  type = list(string)
}

variable "ecr" {
    type = object({
        name = string
        scan_on_push = bool
        image_tag_mutability = string
    })
}

variable "instance_profile" {
    type=object({
        name = string
        iam_role_name = string
        iam_policy_suffix = string
    })
}