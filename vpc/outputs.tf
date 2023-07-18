############################################
#           VPC RESOURCE OUTPUT            #
############################################

output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}

output "private_subnets" {
  value = aws_subnet.private_subnet.*.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main_igw.id
}

output "main_sg_id" {
  value = aws_security_group.main_sg.id
}

# output "nat_eip_id" {
#   value = "${aws_eip.nat.id}"
# }

# output "nat_gw_id" {
#   value = "${aws_nat_gateway.nat_gw.id}"
# }

output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "private_route_table_id" {
  value = aws_route_table.private_route_table.*.id
}

output "main_public_ids" {
  value = aws_route_table_association.main_public.*.id
}

output "main_private_ids" {
  value = aws_route_table_association.main_private.*.id
}