# Security Group for Public Instance
resource "aws_security_group" "public_sg" {
  name   = "mbrav-public-sg"
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
    Name = "mbrav-public-sg"
  }
}

# Security Group for Private Instance (no public access)
resource "aws_security_group" "private_sg" {
  name   = "mbrav-private-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      aws_subnet.mbrav_pub_a.cidr_block,
      aws_subnet.mbrav_pub_b.cidr_block,
      aws_subnet.mbrav_pub_c.cidr_block
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mbrav-private-sg"
  }
}
