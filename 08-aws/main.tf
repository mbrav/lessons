# Example Usage of the VPC Module
module "vpc_module_example" {
  source         = "../modules/aws"
  setup_prefix   = "mbrav-main"
  vpc_cidr_block = "10.0.0.0/16"

  public_subnets = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
    "us-east-1c" = "10.0.3.0/24"
    "us-east-1d" = "10.0.4.0/24"
    "us-east-1e" = "10.0.5.0/24"
  }

  private_subnets = {
    "us-east-1a" = "10.0.6.0/24"
    "us-east-1b" = "10.0.7.0/24"
    "us-east-1c" = "10.0.8.0/24"
    "us-east-1d" = "10.0.9.0/24"
    "us-east-1e" = "10.0.10.0/24"
  }
}
