# Modules for network provisioning
module "mbrav-main" {
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

# Public Instance
resource "aws_instance" "debian_pub" {
  ami           = "ami-064519b8c76274859" # Debian 12 Free Tier (adjust if needed)
  instance_type = "t2.micro"
  subnet_id     = module.mbrav-main.public_subnet_ids[0]
  key_name      = module.mbrav-main.ssh_main_key
  vpc_security_group_ids = [
    module.mbrav-main.public_egress_sg_id,
    module.mbrav-main.public_ssh_sg_id,
    module.mbrav-main.public_web_sg_id,
    module.mbrav-main.private_ssh_sg_id
  ]

  user_data                   = file("./scripts/ec2-user-script.sh")
  user_data_replace_on_change = true

  tags = {
    Name   = "mbrav-public-debian-instance"
    Type   = "Server"
    Domain = "Public"
  }
}

# Output the instance name and public IP
output "debian_pub_instance_name" {
  value       = aws_instance.debian_pub.tags["Name"]
  description = "The name of the public Debian instance."
}

output "debian_pub_instance_ip" {
  value       = aws_instance.debian_pub.public_ip
  description = "The public IP address of the public Debian instance."
}

