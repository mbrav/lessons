

# Public Subnets
resource "aws_subnet" "mbrav_pub_a" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "mbrav-public-subnet-a"
    Type = "Public"
  }
}

resource "aws_subnet" "mbrav_pub_b" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "mbrav-public-subnet-b"
    Type = "Public"
  }
}

resource "aws_subnet" "mbrav_pub_c" {
  cidr_block              = "10.0.3.0/24"
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "eu-central-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "mbrav-public-subnet-c"
    Type = "Public"
  }
}

# Private Subnets
resource "aws_subnet" "mbrav_priv_a" {
  cidr_block        = "10.0.4.0/24"
  vpc_id            = aws_vpc.main.id
  availability_zone = "eu-central-1a"

  tags = {
    Name = "mbrav-private-subnet-a"
    Type = "Private"
  }
}

resource "aws_subnet" "mbrav_priv_b" {
  cidr_block        = "10.0.5.0/24"
  vpc_id            = aws_vpc.main.id
  availability_zone = "eu-central-1b"

  tags = {
    Name = "mbrav-private-subnet-b"
    Type = "Private"
  }
}

resource "aws_subnet" "mbrav_priv_c" {
  cidr_block        = "10.0.6.0/24"
  vpc_id            = aws_vpc.main.id
  availability_zone = "eu-central-1c"

  tags = {
    Name = "mbrav-private-subnet-c"
    Type = "Private"
  }
}
