terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "remote" {
    hostname = "app.terraform.io"
    organization = "dataiku-fe-apac"

    workspaces {
      name = "dss-aws"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  
}

