############################################
#           INTERNET GATEWAY               #
############################################
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main_igw"
  }
}