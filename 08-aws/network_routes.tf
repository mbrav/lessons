# Internet Gateway for Public Subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "mbrav-main-igw"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "mbrav-public-route-table"
  }
}

# Associate Public Subnets with the Public Route Table
resource "aws_route_table_association" "pub_a_association" {
  subnet_id      = aws_subnet.mbrav_pub_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pub_b_association" {
  subnet_id      = aws_subnet.mbrav_pub_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pub_c_association" {
  subnet_id      = aws_subnet.mbrav_pub_c.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table (no internet access by default)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "mbrav-private-route-table"
  }
}

# Associate Private Subnets with the Private Route Table
resource "aws_route_table_association" "priv_a_association" {
  subnet_id      = aws_subnet.mbrav_priv_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "priv_b_association" {
  subnet_id      = aws_subnet.mbrav_priv_b.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "priv_c_association" {
  subnet_id      = aws_subnet.mbrav_priv_c.id
  route_table_id = aws_route_table.private_rt.id
}
