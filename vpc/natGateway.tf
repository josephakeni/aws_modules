# /* 
# NAT gatway will is not included in the free tier
# If you want to stay within the free tier comment or 
# avoid using NAT gatway except it is neccessary to do so.
# */

# ################################
# #   ELASTIC IP                 #
# ################################
# resource "aws_eip" "nat" {
#   count      = var.az_count
#   vpc        = true
#   depends_on = [aws_internet_gateway.main_igw]
# }

# ################################
# #   NAT GATEWAY                #
# ################################
# resource "aws_nat_gateway" "nat_gw" {
#   count         = var.az_count
#   allocation_id = element(aws_eip.nat.*.id, count.index)
#   subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
#   tags = {
#     Name = "nat_gw"
#   }
# }

