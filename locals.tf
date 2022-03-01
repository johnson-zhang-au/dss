locals {
  common_tags = {
      "DkuOwner"  = var.DkuOwner
    }
    current_account_id = data.aws_caller_identity.current.account_id
}