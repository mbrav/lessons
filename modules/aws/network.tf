
# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name   = "${var.setup_prefix}-vpc"
    Domain = "Network"
    Domain = "Public/Private"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name   = "${var.setup_prefix}-igw"
    Type   = "Network"
    Domain = "Public"
  }
}

# SUBNETS

# Public subnet
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  cidr_block              = each.value
  vpc_id                  = aws_vpc.main.id
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name   = "${var.setup_prefix}-pubic-subnet-${each.key}"
    Type   = "Network"
    Domain = "Public"
  }
}

# Private subnet
resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  cidr_block        = each.value
  vpc_id            = aws_vpc.main.id
  availability_zone = each.key

  tags = {
    Name   = "${var.setup_prefix}-private-subnet-${each.key}"
    Type   = "Network"
    Domain = "Private"
  }
}


# ROUTE TABLES

# Public rt
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name   = "${var.setup_prefix}-public-route-table"
    Type   = "Network"
    Domain = "Public"
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

# Private rt
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name   = "${var.setup_prefix}-private-route-table"
    Type   = "Network"
    Domain = "Private"
  }
}

resource "aws_route_table_association" "private_assoc" {
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}
