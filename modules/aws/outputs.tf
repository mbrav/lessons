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

output "public_security_group_id" {
  description = "The ID of the public security group"
  value       = aws_security_group.public_sg.id
}

output "private_security_group_id" {
  description = "The ID of the private security group"
  value       = aws_security_group.private_sg.id
}

output "ssh_main_key" {
  description = "The ID of the main ssh key"
  value       = aws_key_pair.main.id
}
