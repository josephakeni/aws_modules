############################################
#           PUBLIC SUBNETS                 #
############################################

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.public_subnets)
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = "true"

  tags = {
    Name        = "${var.name}-public-subnet-${var.environment}-${format("%03d", count.index + 1)}"
    Environment = var.environment
  }
}

############################################
#           PRIVATE SUBNET                 #
############################################

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main.id
  /*
  First IP	10.0.16.0
  Last IP	10.0.31.255
  Total Host	4096
  */
  count             = length(var.private_subnets)
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name        = "${var.name}-private-subnet-${var.environment}-${format("%03d", count.index + 1)}"
    Environment = var.environment
  }
}