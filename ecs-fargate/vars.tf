# variables.tf

variable "name" {
  default = "Tunde"
}

variable "environment" {
  default = "dev"
}

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "eu-west-1"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "jakeni/jotonia-app:myapp1"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 3000
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "health_check_path" {
  default = "/"
}

variable "cpu_size" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "memory_size" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

variable "network_mode" {}
variable "aws_vpc_main" {}
variable "subnets" {}
variable "security_groups" {}
variable "ecs_cluster_name" {}
variable "container_name" {}
variable "launch_type" {}
variable "execution_role_arn" {}
variable "ecs_container_service_autoscale_role" {}
variable "target_type" {}
