
# SECURITY GROUPS

# Public subnet security group
resource "aws_security_group" "public_sg" {
  name   = "${var.setup_prefix}-public-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "${var.setup_prefix}-public-sg"
    Type   = "Security"
    Domain = "Private"
  }
}

# Private subnet security group
resource "aws_security_group" "private_sg" {
  name   = "${var.setup_prefix}-private-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      for pub_subnet in aws_subnet.public_subnets : pub_subnet.cidr_block
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "${var.setup_prefix}-private-sg"
    Type   = "Security"
    Domain = "Public"
  }
}
