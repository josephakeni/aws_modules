# Find the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get the subnet IDs in the default VPC
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "cloudpart1buk"
    key    = "part1/terraform.tfstate"
    region = "${var.aws_region}"
    #    profile = "${var.profile}"
  }
}
