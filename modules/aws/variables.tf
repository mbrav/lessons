variable "setup_prefix" {
  description = "Setup prefix"
  type        = string
  default     = "prod-main"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "A map of public subnet availability zones and their CIDR blocks"
  type        = map(string)
  default = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
    "us-east-1c" = "10.0.3.0/24"
    "us-east-1d" = "10.0.4.0/24"
    "us-east-1e" = "10.0.5.0/24"
  }
}

variable "private_subnets" {
  description = "A map of private subnet availability zones and their CIDR blocks"
  type        = map(string)
  default = {
    "us-east-1a" = "10.0.6.0/24"
    "us-east-1b" = "10.0.7.0/24"
    "us-east-1c" = "10.0.8.0/24"
    "us-east-1d" = "10.0.9.0/24"
    "us-east-1e" = "10.0.10.0/24"
  }
}
