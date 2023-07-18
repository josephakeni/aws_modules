resource "aws_vpc" "main" {
  // cidr block for the main vpc that will make the needed number of IP addresses available
  cidr_block           = var.main_vpc_cidr_block
  instance_tenancy     = var.tenancy
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main_vpc"
  }
}
