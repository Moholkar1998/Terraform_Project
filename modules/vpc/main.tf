resource "aws_vpc" "this" {
  cidr_block = var.cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = var.vpc_name })
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.private_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = false
  tags = merge(var.tags, { Name = "private-subnet-${count.index + 1}" })
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.public_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = merge(var.tags, { Name = "public-subnet-${count.index + 1}" })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(var.tags, { Name = "internet-gateway" })
}

resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? length(var.private_subnets) : 0
  subnet_id = aws_subnet.public[0].id
  allocation_id = aws_eip.nat[count.index].id
  depends_on = [aws_internet_gateway.this]
  tags = merge(var.tags, { Name = "nat-gateway-${count.index + 1}" })
}

resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? length(var.private_subnets) : 0
  domain = "vpc"
  depends_on = [aws_internet_gateway.this]
}
