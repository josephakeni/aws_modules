####################################
#  ROUTE TABLES                    #
####################################
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    /* IP routing is destination based. 
    The destination must be an IP prefix in CIDR notaion e.g 0.0.0.0/0 */
    # cidr_block = Destionation.
    cidr_block = "0.0.0.0/0"
    /* The target must be an AWS network resource such as 
    internet gateway or Elastic Network Interface */
    # gateway_id= Target
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  # count  = var.az_count
  # route {
  #   /* IP routing is destination based. 
  #   The destination must be an IP prefix in CIDR notaion e.g 0.0.0.0/0 */
  #   # cidr_block = Destionation.
  #   cidr_block = "0.0.0.0/0"
  #   /* The target must be an AWS network reso urce such as 
  #   internet gateway or Elastic Network Interface */
  #   # gateway_id= Target
  #   gateway_id = aws_nat_gateway.nat_gw[0].id #element(aws_nat_gateway.nat_gw.*.id, count.index)
  # }

  tags = {
    Name = "private_route_table"
  }
}

####################################
#  ROUTE TABLE ASSOCIATION PUBLIC  #
####################################
/*
If you do not explicitly associate a subnet with a route table 
you created, AWS will implicitly associate it with the main route table
*/
resource "aws_route_table_association" "main_private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}

resource "aws_route_table_association" "main_public" {
  count     = length(var.public_subnets)
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  #route_table_id = aws_route_table.public.id
  route_table_id = element(aws_route_table.public_route_table.*.id, count.index)
}