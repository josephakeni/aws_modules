# Find the default ecs ec2 image
data "aws_ami" "ecs" {
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.202*-x86_64-ebs"]
  }

  most_recent = true
  owners      = ["amazon"]
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "cloudpart1buk"
    key    = "part1/terraform.tfstate"
    region = "eu-west-1" #"${var.aws_region}"
    #    profile = "${var.profile}"
  }
}

data "template_file" "user_data" {
  template = file("../templates/ecs/user_data.sh.tpl")
  vars = {
    ecs_cluster_name = var.ecs_cluster_name
    app_image      = var.app_image
  }
}

data "template_file" "ec2_cb_app" {
  template = file("../templates/ecs/ec2_cb_app.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port = var.app_port
    #   cpu_size    = var.cpu_size
    #   memory_size = var.memory_size
    #   aws_region     = var.aws_region
    #   network_mode = var.network_mode
    container_name = var.container_name
  }
}