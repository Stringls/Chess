# Internet VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = var.enable_dns_hostnames
  enable_dns_hostnames = var.enable_dns_support

  tags = {
    Name      = "main"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "main"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}

####################################
# Route tables
####################################

resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name      = "main-public-1"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}

resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name      = "main-private-1"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}

####################################
# Subnets
####################################

resource "aws_subnet" "main-public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name      = "main-public-1"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}

resource "aws_subnet" "main-public-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}b"

  tags = {
    Name      = "main-public-2"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}

resource "aws_subnet" "main-private-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name      = "main-private-1"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.aws_region}b"

  tags = {
    Name      = "main-private-2"
    Env       = var.env
    ManagedBy = "terraform"
    Repo      = var.repo_url
  }
}

####################################
# route associations
####################################

# resource "aws_route_table_association" "_" {
#   count = length(var.subnet_ids)

#   subnet_id = element(var.subnet_ids, count.index)
#   route_table_id = aws_route_table._.id
# }

# public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = aws_subnet.main-public-2.id
  route_table_id = aws_route_table.main-public.id
}

# private
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = aws_subnet.main-private-1.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "main-private-2-a" {
  subnet_id      = aws_subnet.main-private-2.id
  route_table_id = aws_route_table.main-private.id
}

####################################
# nat gw
####################################

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main-public-1.id

  depends_on = [
    aws_internet_gateway.main-gw
  ]
}