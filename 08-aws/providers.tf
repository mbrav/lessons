terraform {
  required_version = "~> 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "~> 3.0"
    # }
    # archive = {
    #   source  = "hashicorp/archive"
    #   version = "~> 2.0"
    # }
  }
}
# Configure the AWS Provider
provider "aws" {
  region  = "eu-central-1"
  profile = "mbrav-admin"
}
