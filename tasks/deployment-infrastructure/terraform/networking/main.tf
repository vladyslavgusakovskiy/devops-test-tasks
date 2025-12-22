# ------------- Fetch available availability zones -------------
data "aws_availability_zones" "available" {
  state = "available"
}


# ------------- Create a VPC -------------
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block

  tags = {
    Name = "vpc-main"
  }
}

# ------------- Create an Internet Gateway -------------
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "vpc-gateway"
  }
}

# ------------ Create Public Subnets -------------
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public"
  }
}

# ------------- Create a route table for the public subnets -------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public-Route-Table"
  }
}

# ------------- Associate the route table with the public subnets -------------
resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# ------------ Create Private Subnets -------------
resource "aws_subnet" "private_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr_1
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Private"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr_2
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Private"
  }
}

# ------------- Create a route table for the private subnets -------------
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Private-Route-Table"
  }
}

# ------------- Associate the route table with the private subnets -------------
resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_rt.id
}

# ------------- Create a NAT Gateway for private subnets -------------
resource "aws_eip" "nat" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.gw]
}