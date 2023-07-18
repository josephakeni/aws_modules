variable "tenancy" {}

variable "environment" {}

variable "name" {}

variable "main_vpc_cidr_block" {
  # default="10.0.0.0/16"  
}

variable "private_subnets" {
  type = list(any)
  # default= ["10.0.16.0/20", "10.0.32.0/20"]
}

variable "public_subnets" {
  type = list(any)
  #default   = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  type = list(any)
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}