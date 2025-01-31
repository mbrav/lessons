output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = [for subnet in aws_subnet.private_subnets : subnet.id]
}

output "igw_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.igw.id
}

output "public_rt_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_rt.id
}

output "private_rt_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private_rt.id
}

output "public_egress_sg_id" {
  value       = aws_security_group.public_egress.id
  description = "The ID of the public egress security group"
}

output "public_ssh_sg_id" {
  value       = aws_security_group.public_ssh.id
  description = "The ID of the public SSH security group"
}

output "public_web_sg_id" {
  value       = aws_security_group.public_web.id
  description = "The ID of the public web security group"
}

output "private_ssh_sg_id" {
  value       = aws_security_group.private_ssh.id
  description = "The ID of the private SSH security group"
}

output "ssh_main_key" {
  description = "The ID of the main ssh key"
  value       = aws_key_pair.main.id
}
