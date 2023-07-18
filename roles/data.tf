data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "cloudpart1buk"
    key    = "part1/terraform.tfstate"
    region = "${var.aws_region}"
    #    profile = "${var.profile}"
  }
}
