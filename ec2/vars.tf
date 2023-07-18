
variable "instance_count" {}

variable "ami_id" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "iam_role" {}


variable "subnet_id" {}

variable "my_key_name" {
  default = "cloud1b"
}

variable "main_sg_id" {}

variable "bootstrap_script" {}

variable "my_private_key" {
  // This is where the private key is stored on the local machine
  default = "~/.ssh/cloud1a.pem"
}

variable "name" {}
variable "environment" {}
variable "role" {}