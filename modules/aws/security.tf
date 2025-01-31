
# SECURITY GROUPS

# Public Egress security group
resource "aws_security_group" "public_egress" {
  name   = "${var.setup_prefix}-public-egress"
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "${var.setup_prefix}-sg-public-egress"
    Type   = "Security"
    Domain = "Public"
  }
}

# Public SSH subnet security group
resource "aws_security_group" "public_ssh" {
  name   = "${var.setup_prefix}-public-ssh"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow public SSH access
  }

  tags = {
    Name   = "${var.setup_prefix}-sg-public-ssh"
    Type   = "Security"
    Domain = "Public"
  }
}

# Public Web subnet security group
resource "aws_security_group" "public_web" {
  name   = "${var.setup_prefix}-public-web"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "${var.setup_prefix}-sg-public-web"
    Type   = "Security"
    Domain = "Public"
  }
}

# Private SSH subnet security group
resource "aws_security_group" "private_ssh" {
  name   = "${var.setup_prefix}-private-ssh"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      for pub_subnet in aws_subnet.public_subnets : pub_subnet.cidr_block
    ]
  }

  tags = {
    Name   = "${var.setup_prefix}-sg-private-ssh"
    Type   = "Security"
    Domain = "Private"
  }
}
